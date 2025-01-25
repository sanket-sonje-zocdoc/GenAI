//
//  PokemonRowView.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

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
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
            HStack(spacing: 12) {
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
                    .frame(width: 75, height: 75)
                    .onAppear {
                        ImageLoader.shared.loadImage(from: url) { loadedImage in
                            self.image = loadedImage
                        }
                    }
                }

                Text(pokemon.name.capitalized)
                    .font(.headline)

                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
}
