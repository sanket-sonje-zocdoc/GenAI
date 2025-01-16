//
//  JSONMocker.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// A utility class for loading mock JSON data in unit tests.
final class JSONMocker {
    
    /// Loads mock JSON data from a file in the test bundle.
    /// - Parameter filename: The name of the JSON file without the extension
    /// - Returns: The contents of the JSON file as Data
    /// - Throws: Fatal error if the file cannot be found or loaded
    static func loadMockData(from filename: String) -> Data {
        let bundle = Bundle(for: JSONMocker.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename).json from test bundle")
        }

        return data
    }
}
