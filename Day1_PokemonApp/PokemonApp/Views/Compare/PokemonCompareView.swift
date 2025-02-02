//
//  PokemonCompareView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 27/01/25.
//

import PokemonUI

import SwiftUI

/// A view that allows users to compare statistics between two Pokemon side by side
///
/// This view serves as the main container for the Pokemon comparison feature, managing:
/// - Selection of two Pokemon via dropdown pickers
/// - Display of Pokemon sprites for visual reference
/// - Detailed statistical comparison when two Pokemon are selected
///
/// The view uses `PokemonViewModel` to access the list of available Pokemon and
/// manages the state of selected Pokemon internally.
struct PokemonCompareView: View {

    // MARK: - Properties

    /// View model that provides Pokemon data and business logic
    @ObservedObject var viewModel: PokemonViewModel

    /// The first Pokemon selected for comparison
    /// When nil, indicates no Pokemon has been selected
    @State private var selectedPokemon1: Pokemon?

    /// The second Pokemon selected for comparison
    /// When nil, indicates no Pokemon has been selected
    @State private var selectedPokemon2: Pokemon?

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            AppText("Compare Pokemon", style: .title)

            HStack(spacing: 20) {
                PokemonSelectionView(
                    pokemon: $selectedPokemon1,
                    allPokemon: viewModel.pokemons,
                    title: "First Pokemon"
                )

                PokemonSelectionView(
                    pokemon: $selectedPokemon2,
                    allPokemon: viewModel.pokemons,
                    title: "Second Pokemon"
                )
            }
            .padding()

            if let pokemon1 = selectedPokemon1,
               let pokemon2 = selectedPokemon2 {
                PokemonComparisonStatsView(pokemon1: pokemon1, pokemon2: pokemon2)
            } else {
                AppText("Select two Pokemon to compare their stats", style: .caption)
                    .foregroundColor(.gray)
                    .padding()
            }

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    PokemonCompareView(
        viewModel: PokemonViewModel(
            pokemonService: MockPokemonService()
        )
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    PokemonCompareView(
        viewModel: PokemonViewModel(
            pokemonService: MockPokemonService()
        )
    )
    .preferredColorScheme(.dark)
}

// MARK: - Mock Service

private class MockPokemonService: PokemonServiceAPI {
    func fetchList<T>(offset: Int, limit: Int) async throws -> [T] where T : Decodable {
        return [PokemonListItem.mockPokemonListItem, PokemonListItem.mockPokemonListItem] as! [T]
    }

    func fetchItem<T>(url urlString: String) async throws -> T where T : Decodable {
        return Pokemon.mockPokemon as! T
    }
}
