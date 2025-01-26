//
//  AppCardStyle.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import Foundation

/// Defines the visual style of an AppCard
public enum AppCardStyle {

    /// A card without elevation shadow
    case flat

    /// A card with a subtle elevation shadow
    case elevated

    /// The shadow radius for the card style
    /// - Returns: 0 for flat cards, 4 for elevated cards
    var shadowRadius: CGFloat {
        switch self {
        case .flat:
            return 0
        case .elevated:
            return 4
        }
    }

    /// The shadow opacity for the card style
    /// - Returns: 0 for flat cards, 0.1 for elevated cards
    var shadowOpacity: CGFloat {
        switch self {
        case .flat:
            return 0
        case .elevated:
            return 0.1
        }
    }
}
