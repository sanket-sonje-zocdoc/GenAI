//
//  PokemonSelectionView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 27/01/25.
//

import PokemonUI

import SwiftUI

/// A view that provides Pokemon selection functionality with a preview
///
/// This view combines:
/// - A dropdown picker for Pokemon selection
/// - A title to identify the selection context
/// - A sprite preview of the selected Pokemon
///
/// The view is designed to be reusable and can be used for selecting either
/// the first or second Pokemon in the comparison.
///
/// Usage:
/// ```
/// PokemonSelectionView(
///     pokemon: $selectedPokemon,
///     allPokemon: availablePokemon,
///     title: "First Pokemon"
/// )
/// ```
struct PokemonSelectionView: View {

    // MARK: - Properties

    /// Binding to the currently selected Pokemon
    /// When nil, indicates no Pokemon is selected
    @Binding var pokemon: Pokemon?

    /// Array of all available Pokemon that can be selected from
    let allPokemon: [Pokemon]

    /// The title displayed above the selection picker
    /// Used to identify the context of this selection (e.g., "First Pokemon")
    let title: String

    // MARK: - Body

    var body: some View {
        VStack {
            AppText(title, style: .headline)

            AppPicker(
                "Select \(title)",
                selection: $pokemon
            ) {
                AppText("Select Pokemon", style: .title).tag(nil as Pokemon?)

                ForEach(allPokemon, id: \.name) { pokemon in
                    AppText(pokemon.name.capitalized, style: .caption).tag(pokemon as Pokemon?)
                }
            }

            if let pokemon = pokemon {
                AppAvatar(url: URL(string: pokemon.sprites.frontDefault))

                HStack {
                    ForEach(pokemon.types, id: \.type.name) { pokemonTypeEntry in
                        AppTag(
                            text: pokemonTypeEntry.type.name.capitalized,
                            color: Color.getColor(for: pokemonTypeEntry.type.name)
                        )
                    }
                }
                .padding(.top, AppStyle.Padding.xxSmall)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    return Group {
        // Empty state
        PokemonSelectionView(
            pokemon: .constant(nil),
            allPokemon: [Pokemon.mockPokemon, Pokemon.mockPokemon],
            title: "First Pokemon"
        )

        // Selected state
        PokemonSelectionView(
            pokemon: .constant(Pokemon.mockPokemon),
            allPokemon: [Pokemon.mockPokemon, Pokemon.mockPokemon],
            title: "First Pokemon"
        )
    }
}
