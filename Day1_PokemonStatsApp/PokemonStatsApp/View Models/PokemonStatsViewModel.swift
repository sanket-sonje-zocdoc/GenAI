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

    /// Array storing detailed Pokemon information
    @Published var pokemons: [Pokemon] = []

    /// List of basic Pokemon information items
    @Published var pokemonList: [PokemonListItem] = []

    /// Processed RGB data for chart visualization
    @Published var chartData: [RGBChartData] = []

    /// Stores any error that occurs during data fetching
    @Published var error: Error?

    private let pokemonService: PokemonService

    // MARK: - Inits

    init(session: URLSession = .shared) {
        self.pokemonService = PokemonService(session: session)
    }

    // MARK: - Services

    /// Fetches the list of all Pokemon and their corresponding details.
    /// This method initiates the data loading process by:
    /// 1. Fetching the basic Pokemon list
    /// 2. Loading detailed information for each Pokemon
    /// 3. Calculating chart data based on sprite colors
    func fetchPokemonList() {
        Task {
            do {
                pokemonList = try await pokemonService.fetchPokemonList()
                await fetchAllPokemonDetails()
                calculateChartData()
            } catch {
                logger.log("Failed to fetch Pokemon list: \(error.localizedDescription)", level: .error)
                self.error = error
            }
        }
    }

    // MARK: - Private Helpers

    /// Fetches detailed information for each Pokemon in the list.
    /// For each Pokemon, this method:
    /// - Loads detailed Pokemon data
    /// - Processes the sprite image to calculate RGB values
    /// - Adds the results to the pokemons array
    private func fetchAllPokemonDetails() async {
        for pokemon in pokemonList {
            do {
                var pokemonDetails = try await pokemonService.fetchPokemon(url: pokemon.url)

                // Calculate RGB Sum of each pokement
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
