//
//  UIColor+PokemonTypeColor.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// Extension to provide color mapping for Pokemon types
extension Color {
    
    /// Returns a corresponding `Color` for a given Pokemon type
    /// 
    /// This function maps each Pokemon type to a specific color that represents
    /// that type in the user interface. The colors are chosen to match common
    /// Pokemon type representations across various Pokemon media.
    ///
    /// - Parameter type: The Pokemon type for which to get the corresponding color
    /// - Returns: A `Color` instance representing the Pokemon type
    ///
    /// Example:
    /// ```
    /// let fireColor = Color.getColor(for: PokemonType(name: "fire"))
    /// // Returns .red
    /// ```
    static func getColor(for type: PokemonType) -> Color {
        switch type.name.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "psychic": return .purple
        case "ice": return .cyan
        case "dragon": return .indigo
        case "dark": return Color(.darkGray)
        case "fairy": return .pink
        case "normal": return Color(.lightGray)
        case "fighting": return .orange
        case "flying": return Color(.systemTeal)
        case "poison": return .purple
        case "ground": return .brown
        case "rock": return Color(.darkGray)
        case "bug": return Color(.systemGreen)
        case "ghost": return .purple
        case "steel": return Color(.lightGray)
        default: return Color(.systemGray)
        }
    }
}
