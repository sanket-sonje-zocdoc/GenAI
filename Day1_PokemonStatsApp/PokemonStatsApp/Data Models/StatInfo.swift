//
//  StatInfo.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Contains detailed information about a specific stat type
struct StatInfo: Codable {

    /// The name of the stat (e.g., "hp", "attack", "defense")
    let name: String

    /// URL containing additional information about the stat
    let url: String
}
