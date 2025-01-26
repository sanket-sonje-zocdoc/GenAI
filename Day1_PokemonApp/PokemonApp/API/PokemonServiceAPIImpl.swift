//
//  PokemonServiceAPIImpl.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation
import PokemonUI

/// A concrete implementation of PokemonServiceAPI that fetches Pokemon data from the Pokemon API.
/// This service handles network requests to the PokeAPI (pokeapi.co) and provides methods to fetch
/// both paginated lists of Pokemon and detailed information about specific Pokemon.
class PokemonServiceAPIImpl: PokemonServiceAPI {

    // MARK: - Properties

    /// Logger instance used for debugging and error tracking
    private let logger = Logger.shared

    /// URLSession instance used for making network requests
    private let session: URLSession

    // MARK: - Initialization

    /// Initializes a new instance of the Pokemon service
    /// - Parameter session: The URLSession to use for network requests. Defaults to shared session.
    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - API's

    /// Fetches a paginated list of Pokemon from the API
    /// - Parameters:
    ///   - offset: The starting index for pagination
    ///   - limit: The maximum number of items to fetch
    /// - Returns: An array of decoded items of type T
    /// - Throws: NetworkError, URLError, or DecodingError if the request fails
    func fetchList<T: Decodable>(offset: Int, limit: Int) async throws -> [T] {
        let url = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)"
        let response: PaginatedResponse<T> = try await fetch(url: url)
        return response.results
    }

    /// Fetches detailed information about a specific Pokemon
    /// - Parameter url: The full URL to fetch the Pokemon details
    /// - Returns: A decoded item of type T
    /// - Throws: NetworkError, URLError, or DecodingError if the request fails
    func fetchItem<T: Decodable>(url: String) async throws -> T {
        return try await fetch(url: url)
    }

    // MARK: - Private Helpers

    /// Generic method to fetch and decode data from a URL
    /// - Parameter urlString: The URL string to fetch data from
    /// - Returns: A decoded item of type T
    /// - Throws:
    ///   - URLError.badURL if the URL string is invalid
    ///   - URLError.badServerResponse if the response is not HTTP
    ///   - NetworkError.invalidStatusCode if the status code is not 2xx
    ///   - DecodingError if the response cannot be decoded to type T
    private func fetch<T: Decodable>(url urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                logger.log("Invalid response type", level: .error)
                throw URLError(.badServerResponse)
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                logger.log("HTTP Error: Status code \(httpResponse.statusCode)", level: .error)
                throw NetworkError.invalidStatusCode(httpResponse.statusCode)
            }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            logger.log("Decoding error: \(decodingError)", level: .error)
            throw decodingError
        } catch {
            logger.log("Network error: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
}
