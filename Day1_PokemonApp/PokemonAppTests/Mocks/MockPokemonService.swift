//
//  MockPokemonService.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import Foundation

@testable import PokemonApp

/// A mock implementation of `PokemonServiceAPI` used for testing purposes.
/// This class provides controllable responses for Pokemon-related network requests
/// without making actual API calls.
class MockPokemonService: PokemonServiceAPI {
    
    // MARK: - Properties
    
    /// Dictionary to store mock responses for different types
    private var mockResponses: [String: Any] = [:]
    
    /// An optional error to be thrown by the mock methods
    var mockError: Error?
    
    // MARK: - Setup Methods
    
    /// Sets up a mock response for a specific type
    /// - Parameter response: The mock response to return
    /// - Parameter type: The type of the response, used as a key for storage
    func setMockResponse<T>(_ response: T, for type: T.Type) {
        let key = String(describing: type)
        mockResponses[key] = response
        
        // If it's an array type, also store it with the element type as key
        if let arrayResponse = response as? [Any],
           let elementType = type as? [Any].Type {
            let elementTypeString = String(describing: elementType).replacingOccurrences(of: "Array<", with: "").dropLast()
            mockResponses[String(elementTypeString)] = arrayResponse
        }
    }
    
    // MARK: - API Implementation
    
    /// Simulates fetching a paginated list of items
    /// - Parameters:
    ///   - offset: The starting position in the list
    ///   - limit: The maximum number of items to return
    /// - Returns: An array of type T from the mock responses
    /// - Throws: MockError.responseNotFound if no mock is set, or mockError if specified
    func fetchList<T>(offset: Int, limit: Int) async throws -> [T] where T : Decodable {
        if let error = mockError {
            throw error
        }
        
        let key = String(describing: [T].self)
        guard let response = mockResponses[key] as? [T] else {
            throw MockError.responseNotFound(type: T.self)
        }
        
        return response
    }
    
    /// Simulates fetching a single item
    /// - Parameter url: The URL for the item (unused in mock)
    /// - Returns: An item of type T from the mock responses
    /// - Throws: MockError.responseNotFound if no mock is set, or mockError if specified
    func fetchItem<T>(url urlString: String) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        
        let key = String(describing: T.self)
        guard let response = mockResponses[key] as? T else {
            throw MockError.responseNotFound(type: T.self)
        }
        
        return response
    }
}
