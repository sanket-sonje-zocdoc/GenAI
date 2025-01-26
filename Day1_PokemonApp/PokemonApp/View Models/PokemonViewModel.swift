//
//  PokemonStatsViewModel.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation
import PokemonUI

/// A view model that manages Pokemon data and statistics for the Pokemon Stats app.
/// This class handles fetching, filtering, sorting and pagination of Pokemon data.
///
/// The view model supports:
/// - Paginated loading of Pokemon data
/// - Filtering Pokemon by name or type
/// - Sorting Pokemon by various attributes (name, HP, attack, etc.)
/// - Error handling and loading state management
@MainActor
class PokemonViewModel: ObservableObject {

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

    /// Current sort option
    @Published var sortOption: SortOption = .name
    
    /// Current sort order (ascending/descending)
    @Published var sortAscending = true

    // MARK: - Inits

    init(pokemonService: PokemonServiceAPI) {
        self.pokemonService = pokemonService
    }

    // MARK: - Services

    /// Fetches the initial batch of Pokemon data, clearing any existing data.
    /// This method resets the pagination offset and clears current Pokemon arrays
    /// before fetching the first batch of data.
    func fetchInitialPokemonList() async {
        currentOffset = 0
        pokemons.removeAll()
        pokemonList.removeAll()
        await fetchNextBatch()
    }

    /// Loads the next batch of Pokemon data when the user reaches the end of the list.
    /// This method will only fetch more data if:
    /// - There is no ongoing loading operation
    /// - There is more data available to fetch
    func loadMorePokemon() async {
        guard !isLoadingMore && hasMoreData else { return }
        await fetchNextBatch()
    }

    /// Filters the Pokemon array based on the provided search criteria.
    /// - Parameters:
    ///   - query: The search text to filter Pokemon by. Case-insensitive.
    ///   - mode: The search mode to apply:
    ///     - `.name`: Filters Pokemon whose names contain the query string
    ///     - `.type`: Filters Pokemon whose types contain the query string
    /// - Returns: A filtered array of Pokemon matching the search criteria.
    ///           Returns the complete Pokemon array if the query is empty.
    func filterPokemons(for query: String, mode: SearchMode) -> [Pokemon] {
        guard !query.isEmpty else {
            return pokemons
        }

        let lowercasedQuery = query.lowercased()

        switch mode {

        case .name:
            return pokemons.filter {
                $0.name.lowercased().contains(lowercasedQuery)
            }

        case .type:
            return pokemons.filter { pokemon in
                pokemon.types.contains { type in
                    type.type.name.lowercased().contains(lowercasedQuery)
                }
            }
        }
    }

    /// Sorts the Pokemon array based on the current `sortOption` and `sortAscending` values.
    /// - Parameter pokemons: The array of Pokemon to sort
    /// - Returns: A new array containing the sorted Pokemon based on:
    ///   - Name (alphabetically)
    ///   - Stats (HP, Attack, Defense, Special Attack, Special Defense, Speed)
    ///   The sort direction is determined by the `sortAscending` property
    func sortPokemons(_ pokemons: [Pokemon]) -> [Pokemon] {
        switch sortOption {
        case .name:
            return pokemons.sorted { p1, p2 in
                sortAscending ? p1.name < p2.name : p1.name > p2.name
            }
            
        case .hp, .attack, .defense, .specialAttack, .specialDefense, .speed:
            return pokemons.sorted { p1, p2 in
                let stat1 = p1.stats.first { $0.stat.name == sortOption.statName }?.baseStat ?? 0
                let stat2 = p2.stats.first { $0.stat.name == sortOption.statName }?.baseStat ?? 0
                return sortAscending ? stat1 < stat2 : stat1 > stat2
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
        
        // Sort using the current sort option and direction
        pokemons = sortPokemons(pokemons)
    }
}
