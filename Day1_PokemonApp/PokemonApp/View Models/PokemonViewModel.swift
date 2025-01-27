//
//  PokemonStatsViewModel.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

import PokemonUI
import PokemonUtils

/// A view model that manages Pokemon data and statistics.
///
/// This class provides functionality for:
/// - Loading and paginating Pokemon data
/// - Filtering Pokemon by name or type
/// - Multi-criteria sorting with customizable order
/// - Error and loading state management
///
/// # Key Features
/// - Paginated loading: Loads Pokemon in batches of 25 to optimize performance
/// - Search functionality: Supports filtering by Pokemon name or type
/// - Advanced sorting: Allows multiple sort criteria with customizable order
/// - Error handling: Provides error state management and logging
///
/// # Usage Example
/// ```swift
/// let viewModel = PokemonViewModel(pokemonService: PokemonService())
///
/// // Load initial data
/// await viewModel.fetchInitialPokemonList()
///
/// // Add sort criteria
/// viewModel.addSortCriteria(option: .name, ascending: true)
/// viewModel.addSortCriteria(option: .hp, ascending: false)
///
/// // Filter Pokemon
/// let filtered = viewModel.filterPokemons(for: "fire", mode: .type)
/// ```
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
    @Published var pokemonListItems: [PokemonListItem] = []

    /// Stores any error that occurs during data fetching
    @Published var error: Error?

    /// Indicates if more data is being loaded
    @Published var isLoadingMore = false

    /// Current sort option
    @Published var sortOption: SortOption = .name

    /// Current sort order (ascending/descending)
    @Published var sortAscending = true

    /// Array of active sort criteria in order of priority
    @Published var sortCriteria: [SortCriteria] = []

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
        pokemonListItems.removeAll()
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

    /// Sorts the Pokemon array based on multiple sort criteria
    /// - Parameter pokemons: The array of Pokemon to sort
    /// - Returns: A new array containing the sorted Pokemon
    func sortPokemons(_ pokemons: [Pokemon]) -> [Pokemon] {
        return pokemons.sorted { p1, p2 in
            for criteria in sortCriteria {
                let comparison = comparePokemon(p1, p2, by: criteria)
                if comparison != .orderedSame {
                    return criteria.ascending ? comparison == .orderedAscending : comparison == .orderedDescending
                }
            }

            // Keep original order if all criteria are equal
            return false
        }
    }

    /// Adds a new sort criteria or updates existing one
    /// - Parameters:
    ///   - option: The sort option to add/update
    ///   - ascending: The sort direction
    func addSortCriteria(option: SortOption, ascending: Bool) {
        if let index = sortCriteria.firstIndex(where: { $0.option == option }) {
            sortCriteria.remove(at: index)
        }
        sortCriteria.append(SortCriteria(option: option, ascending: ascending))
    }

    /// Removes a sort criteria
    /// - Parameter option: The sort option to remove
    func removeSortCriteria(option: SortOption) {
        sortCriteria.removeAll { $0.option == option }
    }

    // MARK: - Private Helpers

    /// Fetches the next batch of Pokemon data
    private func fetchNextBatch() async {
        isLoadingMore = true

        do {
            let newPokemonListItems: [PokemonListItem] = try await pokemonService.fetchList(
                offset: currentOffset,
                limit: pageSize
            )

            // If we received fewer items than requested, we've reached the end
            hasMoreData = newPokemonListItems.count == pageSize

            // Update the offset for the next batch
            currentOffset += newPokemonListItems.count

            // Append new items to the list
            pokemonListItems.append(contentsOf: newPokemonListItems)

            // Fetch details for new Pokemon
            await fetchPokemonDetails(for: newPokemonListItems)

        } catch {
            logger.log("Failed to fetch Pokemon list: \(error.localizedDescription)", level: .error)
            self.error = error
        }

        isLoadingMore = false
    }

    /// Fetches detailed information for specific Pokemon in the list
    private func fetchPokemonDetails(for pokemonListItems: [PokemonListItem]) async {
        for pokemonListItem in pokemonListItems {
            do {
                let pokemon: Pokemon = try await pokemonService.fetchItem(
                    url: pokemonListItem.url
                )
                pokemons.append(pokemon)
            } catch {
                logger.log("Error fetching \(pokemonListItem.name): \(error)", level: .error)
            }
        }
    }

    /// Compares two Pokemon based on a specified sort criteria
    /// - Parameters:
    ///   - p1: First Pokemon to compare
    ///   - p2: Second Pokemon to compare
    ///   - criteria: The sort criteria to use for comparison, including:
    ///     - `.name`: Compares Pokemon names alphabetically
    ///     - `.type`: Compares concatenated type strings alphabetically
    ///     - Stats (`.hp`, `.attack`, etc.): Compares base stat values numerically
    /// - Returns: A `ComparisonResult` indicating the relative order:
    ///   - `.orderedAscending`: if p1 should come before p2
    ///   - `.orderedDescending`: if p1 should come after p2
    ///   - `.orderedSame`: if p1 and p2 are equal for the given criteria
    private func comparePokemon(_ p1: Pokemon, _ p2: Pokemon, by criteria: SortCriteria) -> ComparisonResult {
        switch criteria.option {
        case .name:
            return p1.name.compare(p2.name)

        case .type:
            let types1 = p1.types.map { $0.type.name }.joined(separator: ",")
            let types2 = p2.types.map { $0.type.name }.joined(separator: ",")
            return types1.compare(types2)

        case .hp, .attack, .defense, .specialAttack, .specialDefense, .speed:
            let stat1 = p1.stats.first { $0.stat.name == criteria.option.statName }?.baseStat ?? 0
            let stat2 = p2.stats.first { $0.stat.name == criteria.option.statName }?.baseStat ?? 0
            return stat1 == stat2 ? .orderedSame : (stat1 < stat2 ? .orderedAscending : .orderedDescending)
        }
    }
}
