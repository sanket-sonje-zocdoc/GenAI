//
//  PokemonDetailView.swift
//  PokemonStatsApp
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
        VStack(spacing: 16) {
            if let url = URL(string: pokemon.sprites.frontDefault) {
                Group {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
                .onAppear {
                    ImageLoader.shared.loadImage(from: url) { loadedImage in
                        self.image = loadedImage
                    }
                }
            }

            Text(pokemon.name.capitalized)
                .font(.title)

            ForEach(pokemon.stats, id: \.stat.name) { stat in
                HStack {
                    Text(stat.stat.name.capitalized)
                        .font(.headline)
                    Spacer()
                    Text("\(stat.baseStat)")
                        .font(.body)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Pokemon Details")
    }
}
