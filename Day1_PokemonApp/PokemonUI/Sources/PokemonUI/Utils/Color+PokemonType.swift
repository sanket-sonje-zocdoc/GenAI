//
//  UIColor+PokemonTypeColor.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// Extension to provide color mapping for Pokemon types
///
/// This extension adds functionality to SwiftUI's `Color` type to support
/// Pokemon type-specific colors. It provides a consistent color scheme
/// that matches the traditional color representations of Pokemon types
/// across various Pokemon games and media.
@available(iOS 18.0, *)
extension Color {

    /// Maps a Pokemon type name to its corresponding visual representation color
    /// 
    /// This function provides a standardized color mapping for all 18 Pokemon types,
    /// ensuring consistent visual representation throughout the application.
    ///
    /// - Parameter typeName: A string representing the Pokemon type (case-insensitive)
    /// - Returns: A `Color` instance that visually represents the Pokemon type
    ///
    /// The color mapping follows these conventions:
    /// - Fire → Red
    /// - Water → Blue
    /// - Grass → Green
    /// - Electric → Yellow
    /// - Psychic/Ghost/Poison → Purple
    /// - Ice → Cyan
    /// - Dragon → Indigo
    /// - Dark/Rock → Dark Gray
    /// - Fairy → Pink
    /// - Normal/Steel → Light Gray
    /// - Fighting → Orange
    /// - Flying → Teal
    /// - Ground → Brown
    /// - Bug → System Green
    ///
    /// Example usage:
    /// ```swift
    /// let fireTypeColor = Color.getColor(for: "fire")    // Returns .red
    /// let waterTypeColor = Color.getColor(for: "water")  // Returns .blue
    /// ```
    ///
    /// If an unknown type is provided, the function returns a default system gray color.
    public static func getColor(for typeName: String) -> Color {
        switch typeName.lowercased() {
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
