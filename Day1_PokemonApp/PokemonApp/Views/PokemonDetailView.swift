//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// A view that displays detailed information about a specific Pokemon.
///
/// This view shows:
/// - A large sprite image of the Pokemon
/// - The Pokemon's name
/// - A list of base stats including:
///   - HP
///   - Attack
///   - Defense
///   - Special Attack
///   - Special Defense
///   - Speed
///
/// The view handles different states for the sprite image:
/// - Loading state: Shows a progress indicator while the image loads
/// - Success state: Displays the Pokemon's sprite image
/// - Error state: Gracefully handles missing images by not displaying anything
struct PokemonDetailView: View {

    // MARK: - Properties

    /// The Pokemon model containing all the details to be displayed
    let pokemon: Pokemon
    @State private var image: UIImage?

    // MARK: - Body

    var body: some View {
        VStack(spacing: AppStyle.Padding.normal) {
            AppCard {
                AppAvatar(
                    url: URL(string: pokemon.sprites.frontDefault),
                    size: 150
                )
            }

            AppText(pokemon.name.capitalized, style: .title)

            ForEach(pokemon.stats, id: \.stat.name) { stat in
                AppCard {
                    HStack {
                        AppText(stat.stat.name.capitalized, style: .headline)
                        Spacer()
                        AppText("\(stat.baseStat)", style: .body)
                    }
                }
            }

            Spacer()
        }
        .padding(AppStyle.Padding.normal)
        .navigationTitle("Pokemon Details")
    }
}

// MARK: - Preview

#Preview {
    PokemonDetailView(
        pokemon: Pokemon.mockPokemon
    )
}
