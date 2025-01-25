//
//  Sprites.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Contains URLs for various Pokemon sprite images
struct Sprites: Codable, Equatable {

    /// URL for the default front-facing sprite
    let frontDefault: String

    /// URL for the shiny front-facing sprite
    let frontShiny: String?
    
    /// Coding keys for JSON decoding/encoding
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    // MARK: - Equatable

    static func == (lhs: Sprites, rhs: Sprites) -> Bool {
        return lhs.frontDefault == rhs.frontDefault &&
               lhs.frontShiny == rhs.frontShiny
    }
}
