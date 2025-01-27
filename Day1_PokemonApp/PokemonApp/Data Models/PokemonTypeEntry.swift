//
//  PokemonTypeEntry.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

/// A model representing a Pokemon's type entry in the Pokemon data structure.
/// Each Pokemon can have up to two types, represented by slot numbers (1 or 2).
struct PokemonTypeEntry: Codable, Equatable, Hashable {

    /// The slot number of the type (1 for primary type, 2 for secondary type if present)
    let slot: Int
    
    /// The Pokemon type associated with this entry (e.g., Fire, Water, Grass, etc.)
    let type: PokemonType

    /// Coding keys for JSON decoding/encoding
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }

    // MARK: - Equatable

    static func == (lhs: PokemonTypeEntry, rhs: PokemonTypeEntry) -> Bool {
        return lhs.slot == rhs.slot &&
               lhs.type == rhs.type
    }
}
