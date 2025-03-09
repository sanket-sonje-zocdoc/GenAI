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
                HStack(spacing: AppStyle.StackSpacing.xSmall) {
                    AppAvatar(
                        url: URL(string: pokemon.sprites.frontDefault),
                        accessibilityID: pokemon.name
                    )

                    VStack(alignment: .leading, spacing: AppStyle.StackSpacing.xxSmall) {
                        AppText(pokemon.name.capitalized, style: .headline)

                        HStack(spacing: AppStyle.StackSpacing.xSmall) {
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
                        imageName: "chevron.right",
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
