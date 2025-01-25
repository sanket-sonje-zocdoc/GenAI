//
//  PokemonStatsViewModel.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// A view model that manages Pokemon data and statistics for the Pokemon Stats app.
/// This class handles fetching Pokemon data, processing sprite colors, and preparing chart data.
@MainActor
class PokemonStatsViewModel: ObservableObject {

    // MARK: - Properties

    private let logger = Logger.shared
    private let pageSize = 25
    private var currentOffset = 0
    private var hasMoreData = true

    private let pokemonService: PokemonService

    /// Array storing detailed Pokemon information
    @Published var pokemons: [Pokemon] = []

    /// List of basic Pokemon information items
    @Published var pokemonList: [PokemonListItem] = []

    /// Processed RGB data for chart visualization
    @Published var chartData: [RGBChartData] = []

    /// Stores any error that occurs during data fetching
    @Published var error: Error?

    /// Indicates if more data is being loaded
    @Published var isLoadingMore = false

    // MARK: - Inits

    init(session: URLSession = .shared) {
        self.pokemonService = PokemonService(session: session)
    }

    // MARK: - Services

    /// Fetches the initial batch of Pokemon
    func fetchInitialPokemonList() {
        currentOffset = 0
        pokemons.removeAll()
        pokemonList.removeAll()
        chartData.removeAll()
        
        Task {
            await fetchNextBatch()
        }
    }
    
    /// Loads more Pokemon when user scrolls
    func loadMorePokemon() {
        guard !isLoadingMore && hasMoreData else { return }
        
        Task {
            await fetchNextBatch()
        }
    }
    
    /// Fetches the next batch of Pokemon data
    private func fetchNextBatch() async {
        isLoadingMore = true
        
        do {
            let newPokemonList = try await pokemonService.fetchPokemonList(
                offset: currentOffset,
                limit: pageSize
            )
            
            // If we received fewer items than requested, we've reached the end
            hasMoreData = newPokemonList.count == pageSize
            
            // Update the offset for the next batch
            currentOffset += newPokemonList.count
            
            // Append new items to the list
            pokemonList.append(contentsOf: newPokemonList)
            
            // Fetch details for new Pokemon
            await fetchPokemonDetails(for: newPokemonList)
            
            // Recalculate chart data with all Pokemon
            calculateChartData()
            
        } catch {
            logger.log("Failed to fetch Pokemon list: \(error.localizedDescription)", level: .error)
            self.error = error
        }
        
        isLoadingMore = false
    }
    
    /// Fetches detailed information for specific Pokemon in the list
    private func fetchPokemonDetails(for pokemonList: [PokemonListItem]) async {
        for pokemon in pokemonList {
            do {
                var pokemonDetails = try await pokemonService.fetchPokemon(url: pokemon.url)

                // Calculate RGB Sum of each pokemon
                if let rgbSum = try? await ImageProcessor.calculateRGBSum(
                    from: pokemonDetails.sprites.frontDefault
                ) {
                    pokemonDetails.rgbSum = rgbSum
                }

                pokemons.append(pokemonDetails)
            } catch {
                logger.log("Error fetching \(pokemon.name): \(error)", level: .error)
            }
        }
    }

    // MARK: - Private Helpers

    /// Calculates cumulative RGB sums for chart visualization.
    /// This method processes all Pokemon sprites and creates data points
    /// representing the running total of RGB values for the chart.
    private func calculateChartData() {
        var cumulativeSum = 0
        chartData = pokemons.compactMap { pokemon in
            guard let rgbSum = pokemon.rgbSum else {
                logger.log("Missing RGB data for \(pokemon.name)", level: .error)
                return nil
            }

            cumulativeSum += rgbSum
            return RGBChartData(pokemonName: pokemon.name, cumulativeSum: cumulativeSum)
        }
    }
}
