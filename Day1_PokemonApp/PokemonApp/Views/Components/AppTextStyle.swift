//
//  AppTextStyle.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// Defines the available text styles in the application
enum AppTextStyle {

    case title
    case headline
    case body
    case caption

    /// The font configuration for each text style
    var font: Font {
        switch self {
        case .title:
            return .system(.title, design: .rounded, weight: .bold)
        case .headline:
            return .system(.headline, design: .rounded, weight: .semibold)
        case .body:
            return .system(.body, design: .rounded)
        case .caption:
            return .system(.caption, design: .rounded)
        }
    }

    /// The text color for each style
    var color: Color {
        switch self {
        case .title:
            return Theme.Colors.primaryText
        case .headline:
            return Theme.Colors.primaryText
        case .body:
            return Theme.Colors.primaryText
        case .caption:
            return .white
        }
    }
}
