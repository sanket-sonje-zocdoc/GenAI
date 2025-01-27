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
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            AppText(value1.description, style: .caption)
                .frame(width: 40)
                .foregroundColor(value1 > value2 ? .green : .primary)
            
            AppProgressBar(
                value: Double(value1),
                maxValue: 100
            )
            
            AppText(statName, style: .caption)
                .frame(width: 120)
            
            AppProgressBar(
                value: Double(value2),
                maxValue: 100
            )
            
            AppText(value2.description, style: .caption)
                .frame(width: 40)
                .foregroundColor(value2 > value1 ? .green : .primary)
        }
    }
}

// MARK: - Preview

#Preview("Equal Values") {
    PokemonStatComparisonRow(
        statName: "HP",
        value1: 80,
        value2: 80
    )
}

#Preview("Left Higher") {
    PokemonStatComparisonRow(
        statName: "Attack",
        value1: 100,
        value2: 85
    )
}

#Preview("Right Higher") {
    PokemonStatComparisonRow(
        statName: "Defense",
        value1: 70,
        value2: 95
    )
}
