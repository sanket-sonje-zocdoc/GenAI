//
//  MockPokemonService.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import Foundation

@testable import PokemonStatsApp

/// A mock implementation of `PokemonServiceAPI` used for testing purposes.
/// This class provides controllable responses for Pokemon-related network requests
/// without making actual API calls.
class MockPokemonService: PokemonServiceAPI {

    // MARK: - properties

    /// An array of mock Pokemon list items to be returned by `fetchPokemonList`.
    var mockPokemonList: [PokemonListItem] = []

    /// A mock Pokemon instance to be returned by `fetchPokemon`.
    /// Defaults to a Pikachu with predefined attributes.
    var mockPokemon = Pokemon(
        id: 25,
        name: "pikachu",
        height: 4,
        weight: 60,
        sprites: Sprites(
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
            frontShiny: ""
        ),
        stats: [
            Stat(
                baseStat: 35,
                effort: 0,
                stat: StatInfo(
                    name: "hp",
                    url: "https://pokeapi.co/api/v2/stat/1/"
                )
            )
        ],
        types: [
            PokemonTypeEntry(
                slot: 1,
                type: PokemonType(
                    name: "electric",
                    url: "https://pokeapi.co/api/v2/type/12/"
                )
            ),
        ]
    )

    /// An optional error to be thrown by the mock methods.
    /// Set this property to simulate error scenarios in tests.
    var mockError: Error?

    // MARK: - Services

    /// Simulates fetching a list of Pokemon.
    /// - Parameters:
    ///   - offset: The starting position in the Pokemon list.
    ///   - limit: The maximum number of items to return.
    /// - Returns: An array of `PokemonListItem` specified in `mockPokemonList`.
    /// - Throws: The error specified in `mockError` if set.
    func fetchPokemonList(offset: Int, limit: Int) async throws -> [PokemonListItem] {
        if let error = mockError {
            throw error
        }

        return mockPokemonList
    }

    /// Simulates fetching a single Pokemon's details.
    /// - Parameter url: The URL for the Pokemon details (unused in mock).
    /// - Returns: The `Pokemon` instance specified in `mockPokemon`.
    /// - Throws: The error specified in `mockError` if set.
    func fetchPokemon(url: String) async throws -> Pokemon {
        if let error = mockError {
            throw error
        }

        return mockPokemon
    }
}
