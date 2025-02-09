//
//  SearchMode.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import Foundation

/// Represents different modes for searching Pokemon
enum SearchMode {

    /// Search Pokemon by their name
    case name

    /// Search Pokemon by their type (e.g., Fire, Water, etc.)
    case type

    /// The placeholder text to display in the search field
    var placeholder: String {
        switch self {
            case .name: return "Search By Name"
            case .type: return "Search By Type"
        }
    }

    /// The SF Symbol icon name associated with each search mode
    var icon: String {
        switch self {
            case .name: return "person.fill"
            case .type: return "tag.fill"
        }
    }
}
