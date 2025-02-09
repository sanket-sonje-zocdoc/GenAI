//
//  PokemonRowView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import PokemonUI
import SwiftUI
import UIKit

/// A reusable row view that displays basic Pokemon information in a list.
///
/// This view shows:
/// - A small sprite image of the Pokemon (75x75)
/// - The Pokemon's name (capitalized)
///
/// The view handles different states for the sprite image:
/// - Loading state: Shows a progress indicator while the image loads
/// - Success state: Displays the Pokemon's sprite image
/// - Error state: Gracefully handles missing images by not displaying anything
///
/// When tapped, this row navigates to a detailed view of the Pokemon.
struct PokemonRowView: View {

    // MARK: - Properties

    /// The Pokemon model containing all the details to be displayed
    let pokemon: Pokemon

    // MARK: - Body

    var body: some View {
        ZStack {
            AppCard {
                HStack(spacing: AppStyle.Padding.xSmall * 1.5) {
                    AppAvatar(
                        url: URL(string: pokemon.sprites.frontDefault),
                        accessibilityID: pokemon.name
                    )

                    VStack(alignment: .leading, spacing: AppStyle.Padding.xxSmall) {
                        AppText(pokemon.name.capitalized, style: .headline)

                        HStack(spacing: AppStyle.Padding.xSmall) {
                            ForEach(pokemon.types, id: \.slot) { pokemonTypeEntry in
                                AppTag(
                                    text: pokemonTypeEntry.type.name.capitalized,
                                    color: Color.getColor(for: pokemonTypeEntry.type.name)
                                )
                            }
                        }
                    }

                    Spacer()

                    AppIcon(
                        systemName: "chevron.right",
                        accessibilityID: "Right Icon"
                    )
                        .padding(.trailing, AppStyle.Padding.xSmall)
                        .padding(.leading, AppStyle.Padding.xxSmall)
                }
            }

            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                EmptyView()
            }
            .opacity(0)
        }
        .listRowSeparator(.hidden, edges: .all)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        List {
            PokemonRowView(pokemon: Pokemon.mockPokemon)
        }
    }
}

// MARK: - Mock Data

extension Pokemon {
    static var mockPokemon: Pokemon {
        Pokemon(
            id: 25,
            name: "pikachu",
            height: 4,
            weight: 60,
            sprites: Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                frontShiny: ""
            ),
            stats: [
                Stat(
                    baseStat: 35,
                    effort: 0,
                    stat: StatInfo(
                        name: "hp",
                        url: "https://pokeapi.co/api/v2/stat/1/"
                    )
                )
            ],
            types: [
                PokemonTypeEntry(
                    slot: 1,
                    type: PokemonType(
                        name: "electric",
                        url: "https://pokeapi.co/api/v2/type/12/"
                    )
                ),
            ]
        )
    }
}

extension PokemonListItem {
    static var mockPokemonListItem: PokemonListItem {
        PokemonListItem(
            name: "pikachu",
            url: "https://pokeapi.co/api/v2/pokemon/25/"
        )
    }
}
