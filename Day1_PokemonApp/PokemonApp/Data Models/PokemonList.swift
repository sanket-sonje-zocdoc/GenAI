//
//  PokemonList.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Represents a paginated list of Pokemon
struct PokemonList: Codable {

    /// The total count of Pokemon available
    let count: Int

    /// URL for the next page of results, if available
    let next: String?

    /// URL for the previous page of results, if available
    let previous: String?

    /// Array of Pokemon items in the current page
    let results: [PokemonListItem]
}
