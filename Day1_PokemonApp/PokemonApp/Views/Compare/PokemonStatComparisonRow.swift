//
//  PokemonStatComparisonRow.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 27/01/25.
//

import PokemonUI

import SwiftUI

/// A view that displays a single row of stat comparison between two Pokemon
///
/// This view presents a horizontal comparison of a single stat, featuring:
/// - Numeric values for both Pokemon
/// - Progress bars for visual comparison
/// - The stat name in the center
/// - Green highlighting for the higher value
///
/// Usage:
/// ```
/// PokemonStatComparisonRow(
///     statName: "Attack",
///     value1: 100,
///     value2: 85
/// )
/// ```
struct PokemonStatComparisonRow: View {

    // MARK: - Properties

    /// The name of the stat being compared (e.g., "Attack", "Defense")
    let statName: String

    /// The stat value for the first Pokemon (displayed on the left)
    let value1: Int

    /// The stat value for the second Pokemon (displayed on the right)
    let value2: Int

    /// The type of the first Pokemon (displayed on the left)
    let type1: String

    /// The type of the second Pokemon (displayed on the right)
    let type2: String

    private var maxValue: Int {
        max(value1, value2)
    }

    private var lowerValue: Int {
        min(value1, value2)
    }

    private var isFirstPokemonStronger: Bool {
        value1 > value2
    }

    // MARK: - Body

    var body: some View {
        AppCard {
            HStack(spacing: AppStyle.StackSpacing.normal) {
                AppText("\(value1)", style: .body)
                    .foregroundColor(isFirstPokemonStronger ? .green : .primary)
                    .frame(width: AppStyle.Frame.medium.width, alignment: .trailing)

                AppText(statName, style: .body)
                    .padding(.horizontal, AppStyle.Padding.xxSmall)
                    .background(AppStyle.BackgroundColors.system)
                    .frame(
                        minWidth: AppStyle.Frame.large.width,
                        maxWidth: AppStyle.Frame.xxLarge.width,
                        alignment: .leading
                    )

                ZStack(alignment: .leading) {
                    AppProgressBar(
                        value: Double(maxValue),
                        foregroundColor: Color.getColor(
                            for: isFirstPokemonStronger ? type1 : type2
                        ),
                        accessibilityID: "\(statName)"
                    )
                    .opacity(0.3)

                    AppProgressBar(
                        value: Double(lowerValue),
                        foregroundColor: Color.getColor(
                            for: isFirstPokemonStronger ? type2 : type1
                        ),
                        accessibilityID: "\(statName)"
                    )
                }
                .frame(height: AppStyle.Frame.xSmall.height)

                AppText("\(value2)", style: .body)
                    .foregroundColor(isFirstPokemonStronger ? .primary : .green)
                    .frame(width: AppStyle.Frame.medium.width, alignment: .leading)
            }
            .padding(.horizontal)

        }
    }
}

// MARK: - Preview

#Preview("Equal Values") {
    PokemonStatComparisonRow(
        statName: "HP",
        value1: 80,
        value2: 80,
        type1: "fire",
        type2: "water"
    )

    PokemonStatComparisonRow(
        statName: "Attack",
        value1: 100,
        value2: 850,
        type1: "dragon",
        type2: "fairy"
    )

    PokemonStatComparisonRow(
        statName: "Defense",
        value1: 7,
        value2: 95,
        type1: "grass",
        type2: "steel"
    )
}
