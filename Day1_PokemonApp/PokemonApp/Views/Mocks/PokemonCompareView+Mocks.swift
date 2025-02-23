//
//  PokemonCompareView+Mocks.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 23/02/25.
//

extension PokemonListItem {

    class MockPokemonService: PokemonServiceAPI {
        func fetchList<T>(offset: Int, limit: Int) async throws -> [T] where T : Decodable {
            return [PokemonListItem.mockPokemonListItem, PokemonListItem.mockPokemonListItem] as! [T]
        }

        func fetchItem<T>(url urlString: String) async throws -> T where T : Decodable {
            return Pokemon.mockPokemon as! T
        }
    }
}
