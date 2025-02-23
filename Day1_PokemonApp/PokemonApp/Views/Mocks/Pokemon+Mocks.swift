//
//  Pokemon+Mock.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 23/02/25.
//

extension Pokemon {

    static var mockPokemon: Pokemon {
        Pokemon(
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
    }
}
