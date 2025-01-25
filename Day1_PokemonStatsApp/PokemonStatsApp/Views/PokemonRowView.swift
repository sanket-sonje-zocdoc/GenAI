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

    // MARK: - Body

    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
            HStack(spacing: 12) {
                if let url = URL(string: pokemon.sprites.frontDefault) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 75, height: 75)
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
