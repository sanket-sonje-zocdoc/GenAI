//
//  Untitled.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 26/01/25.
//

/// Errors that can occur in the mock service
enum MockError: Error {

    /// Indicates that no mock response was found for the specified type
    case responseNotFound(type: Any.Type)

}
