//
//  AppStyle+Colors.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines the text color palette for typography across the application.
    /// This enumeration provides a standardized set of text colors to maintain
    /// readability, hierarchy, and consistent visual styling.
    ///
    /// Usage:
    /// ```
    /// Text("Hello")
    ///     .foregroundColor(AppStyle.TextColors.primaryText)
    /// ```
    ///
    /// Features:
    /// - Supports light and dark mode
    /// - Maintains WCAG accessibility standards
    /// - Provides clear visual hierarchy
    public enum TextColors {

        /// Primary text color for high-emphasis content
        ///
        /// Ideal for:
        /// - Headlines and titles
        /// - Body text
        /// - Navigation items
        /// - Interactive labels
        ///
        /// Note: Automatically adapts to the system's appearance settings
        public static let primary = Color.primary

        /// Secondary text color for supporting content
        ///
        /// Ideal for:
        /// - Subtitles and captions
        /// - Helper text
        /// - Disabled states
        /// - Meta information
        ///
        /// Note: Uses 60% opacity for proper visual weight
        public static let secondary = Color.secondary

    }
}
