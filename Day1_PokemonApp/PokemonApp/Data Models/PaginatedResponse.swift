//
//  PaginatedResponse.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 26/01/25.
//

/// A generic structure that represents a paginated response from the PokeAPI.
/// This structure is used to decode paginated API responses where the results
/// can be of any decodable type.
///
/// Example usage:
/// ```
/// let response: PaginatedResponse<PokemonListItem> = try decoder.decode(...)
/// ```
struct PaginatedResponse<T: Decodable>: Decodable {

    /// The total count of items available in the API
    let count: Int

    /// URL string for the next page of results
    /// Will be nil if there are no more pages after this one
    let next: String?

    /// URL string for the previous page of results
    /// Will be nil if this is the first page
    let previous: String?

    /// Array of decoded items of type T
    /// Contains the actual data for the current page
    let results: [T]
}
