//
//  ContentView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import SwiftUI

import PokemonUI

/// A view that displays a list of Pokemon and provides navigation to RGB color analysis.
///
/// This view serves as the main screen of the application with three main components:
/// 1. A list showing all Pokemon names that start with 'A', with each row being tappable
///    to navigate to a detailed view of that Pokemon
/// 2. A button that navigates to a chart view showing RGB color analysis of Pokemon sprites
///
/// The view handles different states:
/// - Loading state: Shows a progress indicator while fetching data
/// - Error state: Displays an alert with error details if data fetching fails
/// - Success state: Shows the interactive Pokemon list and analysis button
///
/// Navigation:
/// - Tapping a Pokemon row navigates to `PokemonDetailView` showing stats and sprite
/// - Tapping "View RGB Analysis" navigates to a chart view with color analysis
///
/// The view uses a `PokemonStatsViewModel` to manage:
/// - Fetching Pokemon data
/// - Maintaining the list of Pokemon
/// - Managing chart data
/// - Handling error states
struct ContentView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: PokemonViewModel
    @State private var searchText = ""
    @State private var searchMode = SearchMode.name

    // MARK: - Initialization

    init(viewModel: PokemonViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.pokemonListItems.isEmpty {
                    AppProgressView()
                } else {
                    SearchBar(
                        text: $searchText,
                        searchMode: $searchMode,
                        sortCriteria: $viewModel.sortCriteria,
                        sortAscending: $viewModel.sortAscending
                    )
                    .padding(.horizontal)

                    List(
                        viewModel.sortPokemons(
                            viewModel.filterPokemons(
                                for: searchText,
                                mode: searchMode
                            )
                        ),
                        id: \.name
                    ) { pokemon in
                        PokemonRowView(pokemon: pokemon)
                            .onAppear {
                                // Load more data when reaching the last few items
                                if pokemon == viewModel.pokemons.last {
                                    Task {
                                        await viewModel.loadMorePokemon()
                                    }
                                }
                            }
                    }
                    .listStyle(.plain)

                    if viewModel.isLoadingMore {
                        AppProgressView()
                    }
                }
            }
            .navigationTitle("Pokemons")
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialPokemonList()
            }
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK") {
                viewModel.error = nil
            }
        } message: {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ContentView(viewModel: PokemonViewModel(pokemonService: PokemonServiceAPIImpl(session: URLSession.shared)))
}
