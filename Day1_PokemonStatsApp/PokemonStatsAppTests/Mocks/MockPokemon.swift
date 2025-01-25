//
//  MockPokemon.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import Foundation

@testable import PokemonStatsApp

struct MockPokemon {

    /// A mock Pokemon instance to be returned by `fetchPokemon`.
    /// Defaults to a Pikachu with predefined attributes.
    static var pikachu = Pokemon(
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

    static var charmander = Pokemon(
        id: 4,
        name: "charmander",
        height: 6,
        weight: 85,
        sprites: Sprites(
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png"
        ),
        stats: [
            Stat(
                baseStat: 39,
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
                    name: "fire",
                    url: "https://pokeapi.co/api/v2/type/10/"
                )
            ),
        ]
    )
}
