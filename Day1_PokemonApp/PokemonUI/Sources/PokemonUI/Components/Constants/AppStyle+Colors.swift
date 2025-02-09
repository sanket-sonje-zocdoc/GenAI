//
//  AppStyle+Colors.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Colors defines the app's color palette and provides consistent color usage across the application.
    /// This enumeration serves as the single source of truth for all color values used throughout the app.
    ///
    /// Benefits:
    /// - Maintains visual consistency across the app
    /// - Simplifies theme management and updates
    /// - Provides semantic meaning to color usage
    /// - Supports accessibility and dark mode adaptations
    public enum Colors {

        /// The primary background color for the application's main surfaces
        ///
        /// Usage:
        /// - Main view backgrounds
        /// - Primary containers
        /// - Full-screen backgrounds
        ///
        /// Specification: Pure white (Color.white)
        public static let primaryBackground = Color.white

        /// The accent background color for the application's main surfaces
        ///
        /// Usage:
        /// - Button backgrounds
        ///
        /// Specification: Pure white (Color.accentColor)
        public static let accentBackground = Color.accentColor

        /// Secondary background color for elevated or distinct surface elements
        ///
        /// Usage:
        /// - Cards and panels
        /// - List items
        /// - Secondary containers
        /// - Section backgrounds
        ///
        /// Specification: Light gray with 10% opacity for subtle distinction
        public static let surfaceBackground = Color.gray.opacity(0.1)

        /// Shadow color for creating depth and elevation effects
        ///
        /// Usage:
        /// - Card shadows
        /// - Elevated components
        /// - Modal presentations
        /// - Interactive elements
        ///
        /// Specification: Gray with 20% opacity for subtle depth perception
        public static let shadow = Color.gray.opacity(0.2)

        /// Primary text color for high-emphasis content
        ///
        /// Usage:
        /// - Headlines and titles
        /// - Primary labels
        /// - Important information
        /// - Interactive text
        ///
        /// Specification: System primary color (automatically adapts to light/dark mode)
        public static let primaryText = Color.primary

        /// Secondary text color for lower-emphasis content
        ///
        /// Usage:
        /// - Subtitles and descriptions
        /// - Supporting text
        /// - Placeholder text
        /// - Disabled state text
        ///
        /// Specification: Gray with 60% opacity for visual hierarchy
        public static let secondaryText = Color.gray.opacity(0.6)

        /// System background color that adapts to the current theme
        ///
        /// Usage:
        /// - System-level backgrounds
        /// - Theme-aware containers
        /// - Modal presentations
        ///
        /// Specification: System background color (automatically adapts to light/dark mode)
        public static let systemBackground = Color(.systemBackground)

        /// Secondary background color that adapts to the current theme
        ///
        /// Usage:
        /// - System-level secondary backgrounds
        /// - Theme-aware containers
        /// - Modal presentations
        ///
        /// Specification: Secondary background color (automatically adapts to light/dark mode)
        public static let secondaryBackground = Color.secondary.opacity(0.1)

    }
}
