//
//  NetworkError.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

/// Represents possible network-related errors that can occur during API requests
enum NetworkError: Error, Equatable {

    /// Indicates that the server responded with an unexpected HTTP status code
    /// - Parameter code: The HTTP status code received from the server
    case invalidStatusCode(Int)
}
