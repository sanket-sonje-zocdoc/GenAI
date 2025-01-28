//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import PokemonUI
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
        ScrollView {
            VStack(spacing: AppStyle.Padding.large) {
                // Pokemon Image Section
                AppCard(style: .elevated) {
                    VStack {
                        AppAvatar(
                            url: URL(string: pokemon.sprites.frontDefault),
                            size: 200
                        )
                        .padding(.vertical, AppStyle.Padding.normal)

                        AppDivider()

                        AppText(pokemon.name.capitalized, style: .title)
                            .padding(.vertical, AppStyle.Padding.xSmall)

                        HStack(spacing: AppStyle.Padding.xSmall) {
                            ForEach(pokemon.types, id: \.type.name) { pokemonTypeEntry in
                                AppTag(
                                    text: pokemonTypeEntry.type.name.capitalized,
                                    color: Color.getColor(for: pokemonTypeEntry.type.name)
                                )
                            }
                        }
                        .padding(.bottom, AppStyle.Padding.xSmall)
                    }
                }
                .padding(.horizontal, AppStyle.Padding.normal)

                // Stats Section
                VStack(spacing: AppStyle.Padding.xSmall) {
                    AppText("Base Stats", style: .headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(pokemon.stats, id: \.stat.name) { stat in
                        AppCard(style: .flat) {
                            HStack {
                                AppText(stat.stat.name.capitalized, style: .headline)

                                Spacer()

                                AppProgressBar(
                                    value: Double(stat.baseStat),
                                    maxValue: 100
                                )
                                .frame(width: 100)

                                AppText("\(stat.baseStat)", style: .body)
                                    .frame(width: 50, alignment: .trailing)
                            }
                            .padding(.vertical, AppStyle.Padding.xSmall)
                        }
                    }
                }
                .padding(.horizontal, AppStyle.Padding.normal)

                Spacer()
            }
            .padding(.vertical, AppStyle.Padding.normal)
        }
        .navigationTitle("Pokemon Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    PokemonDetailView(
        pokemon: Pokemon.mockPokemon
    )
}
