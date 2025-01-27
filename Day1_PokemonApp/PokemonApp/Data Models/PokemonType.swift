//
//  PokemonType.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

/// A model representing a Pokémon's type (e.g., Fire, Water, Grass, etc.)
struct PokemonType: Codable, Equatable, Hashable {

    /// The name of the Pokémon type (e.g., "fire", "water", "grass")
    let name: String
    
    /// The URL pointing to detailed information about this type in the PokeAPI
    let url: String

    /// Coding keys for JSON decoding/encoding
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    // MARK: - Equatable

    static func == (lhs: PokemonType, rhs: PokemonType) -> Bool {
        return lhs.name == rhs.name &&
               lhs.url == rhs.url
    }
}
