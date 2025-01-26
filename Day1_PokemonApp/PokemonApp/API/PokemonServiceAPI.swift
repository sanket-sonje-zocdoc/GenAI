//
//  PokemonServiceAPI.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import Foundation

/// Protocol defining the Pokemon service API interface
protocol PokemonServiceAPI {

    /// Fetches a paginated list of items
    /// - Parameters:
    ///   - offset: The starting position for pagination
    ///   - limit: The number of items to fetch per page
    /// - Returns: An array of items conforming to the specified type, sorted alphabetically.
    /// - Throws: An error if the network request fails or if the JSON decoding fails.
    func fetchList<T: Decodable>(offset: Int, limit: Int) async throws -> [T]

    /// Fetches detailed information about a specific item.
    /// - Parameter url: The URL string pointing to the item's detailed information.
    /// - Returns: An object containing the detailed information.
    /// - Throws: An error if the network request fails or if the JSON decoding fails.
    func fetchItem<T: Decodable>(url urlString: String) async throws -> T
}
