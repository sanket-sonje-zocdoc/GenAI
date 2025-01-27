//
//  PokemonComparisonStatsView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 27/01/25.
//

import PokemonUI

import SwiftUI

/// A view that displays a side-by-side comparison of stats between two Pokemon
///
/// This view presents a vertical list of stat comparisons, including:
/// - Base stats from both Pokemon
/// - Visual progress bars for easy comparison
/// - Highlighting of higher stats in green
///
/// Usage:
/// ```
/// PokemonComparisonStatsView(
///     pokemon1: firstPokemon,
///     pokemon2: secondPokemon
/// )
/// ```
struct PokemonComparisonStatsView: View {

    // MARK: - Properties

    /// The first Pokemon whose stats will be displayed on the left side
    let pokemon1: Pokemon

    /// The second Pokemon whose stats will be displayed on the right side
    let pokemon2: Pokemon

    // MARK: - Body

    var body: some View {
        VStack(spacing: 10) {
            AppText("Stats Comparison", style: .headline)
                .padding(.bottom)

            ForEach(Array(zip(pokemon1.stats, pokemon2.stats)), id: \.0.stat.name) { stat1, stat2 in
                PokemonStatComparisonRow(
                    statName: stat1.stat.name.capitalized,
                    value1: stat1.baseStat,
                    value2: stat2.baseStat,
                    type1: pokemon1.types.first?.type.name ?? "",
                    type2: pokemon2.types.first?.type.name ?? ""
                )
            }
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    PokemonComparisonStatsView(
        pokemon1: Pokemon.mockPokemon,
        pokemon2: Pokemon.mockPokemon
    )
}
