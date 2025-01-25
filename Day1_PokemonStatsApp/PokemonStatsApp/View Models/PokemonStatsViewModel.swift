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

    init(pokemonService: PokemonServiceAPI) {
        self.pokemonService = pokemonService
    }

    // MARK: - Services

    /// Fetches the initial batch of Pokemon
    func fetchInitialPokemonList() async {
        currentOffset = 0
        pokemons.removeAll()
        pokemonList.removeAll()
        await fetchNextBatch()
    }

    /// Loads more Pokemon when user scrolls
    func loadMorePokemon() async {
        guard !isLoadingMore && hasMoreData else { return }
        await fetchNextBatch()
    }

    /// Filters the Pokemon array based on the provided search text
    /// - Parameter searchText: The text to filter Pokemon names by
    /// - Returns: An array of Pokemon whose names contain the search text (case-insensitive).
    ///           If the search text is empty, returns the complete Pokemon array.
    func filterPokemons(for searchText: String) -> [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { pokemon in
                pokemon.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - Private Helpers

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
