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
    /// This centralized color system ensures visual consistency and makes theme updates easier.
    public enum Colors {

        /// The primary background color used for main views and screens
        /// Usage: Main view backgrounds, primary containers
        /// Color: Pure white (Color.white)
        public static let primaryBackground = Color.white

        /// Secondary background color used for cards, sections, and surface elements
        /// Usage: Cards, list items, secondary containers
        /// Color: Light gray with 10% opacity
        public static let surfaceBackground = Color.gray.opacity(0.1)

        /// Shadow color used for elevation effects
        /// Usage: Card shadows, elevated components
        /// Color: Gray with 20% opacity for subtle depth
        public static let shadow = Color.gray.opacity(0.2)

        /// Primary text color for high-emphasis content
        /// Usage: Headlines, important text, primary labels
        /// Color: System primary color (adapts to light/dark mode)
        public static let primaryText = Color.primary

        /// Secondary text color for lower-emphasis content
        /// Usage: Subtitles, descriptions, supporting text
        /// Color: Gray with 60% opacity for reduced emphasis
        public static let secondaryText = Color.gray.opacity(0.6)

    }
}
