//
//  PokemonServiceAPI.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import Foundation

/// Protocol defining the Pokemon service API interface
protocol PokemonServiceAPI {

    /// Fetches a paginated list of Pokemon
    /// - Parameters:
    ///   - offset: The starting position for pagination
    ///   - limit: The number of items to fetch per page
    /// - Returns: An array of `PokemonListItem` objects, sorted alphabetically.
    /// - Throws: An error if the network request fails or if the JSON decoding fails.
    func fetchPokemonListItems(offset: Int, limit: Int) async throws -> [PokemonListItem]

    /// Fetches detailed information about a specific Pokemon.
    /// - Parameter url: The URL string pointing to the Pokemon's detailed information.
    /// - Returns: A `Pokemon` object containing the detailed information.
    /// - Throws: An error if the network request fails or if the JSON decoding fails.
    func fetchPokemon(url urlString: String) async throws -> Pokemon
}
