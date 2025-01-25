//
//  ContentView.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import SwiftUI

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

    @StateObject private var viewModel: PokemonStatsViewModel

    // MARK: - Initialization

    init(session: URLSession) {
        _viewModel = StateObject(
            wrappedValue: PokemonStatsViewModel(
                pokemonService: PokemonServiceAPIImpl(session: session)
            )
        )
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.pokemonList.isEmpty {
                    ProgressView()
                } else {
                    List(viewModel.pokemons, id: \.name) { pokemon in
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
                        ProgressView()
                            .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(session: URLSession.shared)
    }
}
