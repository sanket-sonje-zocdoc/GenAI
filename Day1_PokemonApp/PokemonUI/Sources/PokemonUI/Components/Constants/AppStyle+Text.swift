//
//  AppStyle+Text.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/02/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines standardized font values used throughout the app
    public enum Text: Sendable {

        case caption
        case body
        case headline
        case title
        case customRegular(fontSize: CGFloat, color: Color)

        /// The font configuration for each text style
        public var font: Font {
            switch self {
            case .caption:
                return .calibriLight(AppStyle.FontSize.normal)
            case .body:
                return .calibriRegular(AppStyle.FontSize.medium)
            case .headline:
                return .calibriBold(AppStyle.FontSize.large)
            case .title:
                return .calibriBold(AppStyle.FontSize.xLarge)
            case .customRegular(let fontSize, _):
                return .calibriRegular(fontSize)
            }
        }

        /// The text color for each style
        public var color: Color {
            switch self {
            case .caption:
                return .white
            case .body:
                return AppTheme.Colors.primaryText
            case .headline:
                return AppTheme.Colors.primaryText
            case .title:
                return AppTheme.Colors.primaryText
            case .customRegular(_, let color):
                return color
            }
        }
    }
}
