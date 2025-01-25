//
//  StatInfo.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Contains detailed information about a specific stat type
struct StatInfo: Codable, Equatable {

    /// The name of the stat (e.g., "hp", "attack", "defense")
    let name: String

    /// URL containing additional information about the stat
    let url: String

    // MARK: - Equatable

    static func == (lhs: StatInfo, rhs: StatInfo) -> Bool {
        return lhs.name == rhs.name &&
               lhs.url == rhs.url
    }
}
