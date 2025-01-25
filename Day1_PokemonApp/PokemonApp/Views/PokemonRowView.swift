//
//  PokemonRowView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

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
    @State private var image: UIImage?

    // MARK: - Body

    var body: some View {
        ZStack {
            // Main content
            HStack(spacing: 12) {
                if let url = URL(string: pokemon.sprites.frontDefault) {
                    Group {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        } else {
                            ProgressView()
                                .frame(width: 75, height: 75)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    .frame(width: 75, height: 75)
                    .onAppear {
                        ImageLoader.shared.loadImage(from: url) { loadedImage in
                            withAnimation(.easeIn(duration: 0.2)) {
                                self.image = loadedImage
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(pokemon.name.capitalized)
                        .font(.headline)
                        .foregroundColor(.primary)

                    // Display types as tags
                    HStack(spacing: 8) {
                        ForEach(pokemon.types, id: \.slot) { pokemonTypeEntry in
                            Text(pokemonTypeEntry.type.name.capitalized)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.getColor(for: pokemonTypeEntry.type))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray.opacity(0.6))
                    .font(.system(size: 14, weight: .medium))
                    .padding(.trailing, 8)
                    .padding(.leading, 4)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            )

            // Overlay the NavigationLink with empty label
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
