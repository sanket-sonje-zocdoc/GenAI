//
//  AppTheme.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import Foundation
import SwiftUI
import UIKit

/// Provides centralized theme management for the application's visual styling.
/// This component defines the color palette and styling constants used throughout
/// the application to maintain consistent design.
///
/// Usage:
/// ```
/// Text("Hello")
///     .foregroundColor(Theme.Colors.primaryText)
///     .background(Theme.Colors.background)
/// ```
@available(iOS 15.0, *)
public enum AppTheme {

    /// Defines the color palette used throughout the application.
    /// All colors are loaded from the asset catalog and are compatible with
    /// both light and dark mode if properly configured in the asset catalog.
    public struct Colors {

        /// The main background color used for primary content areas.
        /// Suitable for full-screen backgrounds and main content containers.
        public static let background = Color("Background", bundle: .module)

        /// Background color specifically designed for card-like UI elements.
        /// Provides visual distinction from the main background while maintaining
        /// theme consistency.
        public static let cardBackground = Color("CardBackground", bundle: .module)

        /// The primary text color used for headlines, titles, and body text.
        /// Ensures optimal readability against background colors.
        public static let primaryText = Color("PrimaryText", bundle: .module)

        /// The secondary text color used for supporting text elements.
        /// Suitable for subtitles, captions, and less emphasized text content.
        public static let secondaryText = Color("SecondaryText", bundle: .module)
    }
}
