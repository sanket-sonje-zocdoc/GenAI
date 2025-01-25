//
//  Pokemon.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Represents detailed information about a specific Pokemon
struct Pokemon: Codable, Equatable {

    /// ID of the Pokemon
    let id: Int

    /// Name of the Pokemon
    let name: String

    /// Height of the Pokemon
    let height: Int

    /// Weight of the Pokemon
    let weight: Int

    /// Collection of sprite images for the Pokemon
    let sprites: Sprites

    /// Array of statistics for the Pokemon
    let stats: [Stat]

    /// Collection of Pokemon type entry of the Pokemon
    let types: [PokemonTypeEntry]

    /// Coding keys for JSON decoding/encoding
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case sprites
        case stats
        case types
    }

    // MARK: - Equatable
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.sprites == rhs.sprites &&
               lhs.stats == rhs.stats
    }
}
