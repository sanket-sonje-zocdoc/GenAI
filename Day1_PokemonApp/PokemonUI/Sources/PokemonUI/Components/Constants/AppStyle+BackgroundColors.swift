//
//  AppStyle+Colors.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines the background color palette for the application's various surfaces and containers.
    /// This enumeration provides a centralized collection of background colors to maintain
    /// visual consistency and support different UI states and themes.
    ///
    /// Usage:
    /// ```
    /// view.backgroundColor = AppStyle.BackgroundColors.primaryBackground
    /// ```
    ///
    /// Features:
    /// - Supports light and dark mode adaptations
    /// - Provides semantic color definitions
    /// - Ensures consistent opacity levels
    /// - Maintains accessibility standards
    public enum BackgroundColors {

        /// Primary background color for main content areas
        ///
        /// Ideal for:
        /// - Main view containers
        /// - Primary content areas
        /// - Default view backgrounds
        public static let primary = Color.white

        /// Subtle background color for secondary content
        ///
        /// Ideal for:
        /// - Secondary information containers
        /// - Inactive states
        /// - Subdued UI elements
        public static let secondary = Color.secondary.opacity(0.1)

        /// Dynamic system background that adapts to the user's theme
        ///
        /// Ideal for:
        /// - Full-screen backgrounds
        /// - System-level interfaces
        /// - Modal views
        public static let system = Color(.systemBackground)

        /// Accent background color for interactive elements
        ///
        /// Ideal for:
        /// - Call-to-action buttons
        /// - Interactive elements
        /// - Highlighted content areas
        public static let accent = Color.accentColor

        /// Light background color for elevated UI elements
        ///
        /// Ideal for:
        /// - Cards and panels
        /// - List item backgrounds
        /// - Content grouping areas
        public static let surface = Color.gray.opacity(0.1)

    }
}
