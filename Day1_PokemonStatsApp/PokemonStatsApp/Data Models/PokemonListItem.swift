//
//  PokemonListItem.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Represents a single item in the Pokemon list
struct PokemonListItem: Codable, Identifiable {

    /// Unique identifier for the Pokemon
    var id: String { name }

    /// Name of the Pokemon
    let name: String
    
    /// URL containing detailed information about the Pokemon
    let url: String
}
