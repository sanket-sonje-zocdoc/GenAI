//
//  PokemonService.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// A service class responsible for fetching Pokemon data from the PokeAPI.
class PokemonService {

    // MARK: - Properties

    private let logger = Logger.shared
    private let session: URLSession

    // MARK: - Initialization

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - API's

    /// Fetches a filtered list of Pokemon that start with the letter 'A'.
    /// 
    /// This method retrieves a list of Pokemon from the PokeAPI, filters for names
    /// starting with 'A', and sorts them alphabetically.
    ///
    /// - Returns: An array of `PokemonListItem` objects, sorted alphabetically.
    /// - Throws: An error if the network request fails or if the JSON decoding fails.
    func fetchPokemonList() async throws -> [PokemonListItem] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1000") else {
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

            let list = try JSONDecoder().decode(PokemonList.self, from: data)
            let filteredList = list.results
                .filter { $0.name.lowercased().hasPrefix("a") }
                .sorted { $0.name.lowercased() < $1.name.lowercased() }
            return filteredList
        } catch let decodingError as DecodingError {
            logger.log("Decoding error: \(decodingError)", level: .error)
            throw decodingError
        } catch {
            logger.log("Network error: \(error.localizedDescription)", level: .error)
            throw error
        }
    }

    /// Fetches detailed information about a specific Pokemon.
    ///
    /// - Parameter url: The URL string pointing to the Pokemon's detailed information.
    /// - Returns: A `Pokemon` object containing the detailed information.
    /// - Throws: An error if the network request fails or if the JSON decoding fails.
    func fetchPokemon(url urlString: String) async throws -> Pokemon {
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

            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return pokemon
        } catch let decodingError as DecodingError {
            logger.log("Decoding error: \(decodingError)", level: .error)
            throw decodingError
        } catch {
            logger.log("Network error: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
}
