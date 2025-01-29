//
//  AppTextStyle.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// Defines the available text styles in the application
@available(iOS 15.0, *)
public enum AppTextStyle: Sendable {

    case title
    case headline
    case body
    case caption
    case customRegular(fontSize: CGFloat, color: Color)

    /// The font configuration for each text style
    public var font: Font {
        switch self {
        case .title:
            return .calibriBold(24)
        case .headline:
            return .calibriBold(20)
        case .body:
            return .calibriRegular(16)
        case .caption:
            return .calibriLight(14)
        case .customRegular(let fontSize, _):
            return .calibriRegular(fontSize)
        }
    }

    /// The text color for each style
    public var color: Color {
        switch self {
        case .title:
            return AppTheme.Colors.primaryText
        case .headline:
            return AppTheme.Colors.primaryText
        case .body:
            return AppTheme.Colors.primaryText
        case .caption:
            return .white
        case .customRegular(_, let color):
            return color
        }
    }
}
