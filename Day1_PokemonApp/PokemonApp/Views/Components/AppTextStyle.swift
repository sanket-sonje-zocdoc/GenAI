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
            return .calibriBold(24)
        case .headline:
            return .calibriBold(20)
        case .body:
            return .calibriRegular(16)
        case .caption:
            return .calibriLight(14)
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
