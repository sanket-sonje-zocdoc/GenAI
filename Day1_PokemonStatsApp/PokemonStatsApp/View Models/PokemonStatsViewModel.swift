//
//  PokemonStatsViewModel.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// A view model that manages Pokemon data and statistics for the Pokemon Stats app.
/// This class handles fetching Pokemon data and managing the Pokemon list.
@MainActor
class PokemonStatsViewModel: ObservableObject {

    // MARK: - Properties

    private let logger = Logger.shared
    private let pageSize = 25
    private var currentOffset = 0
    private var hasMoreData = true

    private let pokemonService: PokemonServiceAPI

    /// Array storing detailed Pokemon information
    @Published var pokemons: [Pokemon] = []

    /// List of basic Pokemon information items
    @Published var pokemonList: [PokemonListItem] = []

    /// Stores any error that occurs during data fetching
    @Published var error: Error?

    /// Indicates if more data is being loaded
    @Published var isLoadingMore = false

    // MARK: - Inits

    init(session: URLSession = .shared) {
        self.pokemonService = PokemonServiceAPIImpl(session: session)
    }

    // MARK: - Services

    /// Fetches the initial batch of Pokemon
    func fetchInitialPokemonList() {
        currentOffset = 0
        pokemons.removeAll()
        pokemonList.removeAll()
        
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
                let pokemonDetails = try await pokemonService.fetchPokemon(url: pokemon.url)
                pokemons.append(pokemonDetails)
            } catch {
                logger.log("Error fetching \(pokemon.name): \(error)", level: .error)
            }
        }

        // Sort the entire collection
        pokemons.sort { $0.name < $1.name }
    }
}
