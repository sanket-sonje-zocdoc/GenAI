//
//  SortOption.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 26/01/25.
//

import Foundation

/// Represents different options for sorting Pokemon
///
/// This enum provides various sorting criteria for Pokemon, including their name and base stats.
/// It conforms to `String` and `CaseIterable` to enable easy display in UI elements and iteration over all cases.
enum SortOption: String, CaseIterable {

    /// Sort Pokemon by their name alphabetically
    case name = "Name"

    /// Sort Pokemon by their type alphabetically
    case type = "Type"

    /// Sort Pokemon by their base HP (Hit Points) stat
    case hp = "HP"
    
    /// Sort Pokemon by their base Attack stat
    case attack = "Attack"
    
    /// Sort Pokemon by their base Defense stat
    case defense = "Defense"
    
    /// Sort Pokemon by their base Special Attack stat
    case specialAttack = "Special Attack"
    
    /// Sort Pokemon by their base Special Defense stat
    case specialDefense = "Special Defense"
    
    /// Sort Pokemon by their base Speed stat
    case speed = "Speed"

    /// Returns the corresponding stat name as used in the API
    ///
    /// This property converts the user-friendly enum cases to their corresponding
    /// API stat names. For the name case, it returns an empty string since it's not a stat.
    ///
    /// - Returns: A string representing the stat name used in the Pokemon API
    var statName: String {
        switch self {
        case .name: return ""
        case .type: return ""
        case .hp: return "hp"
        case .attack: return "attack"
        case .defense: return "defense"
        case .specialAttack: return "special-attack"
        case .specialDefense: return "special-defense"
        case .speed: return "speed"
        }
    }
}
