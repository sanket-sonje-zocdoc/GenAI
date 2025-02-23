//
//  AppStyle+Colors.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// Defines the shadow styling configuration for the application's UI elements.
/// This extension provides a centralized definition of shadow-related colors and properties.
@available(iOS 15.0, *)
extension AppStyle {

    /// Defines the shadow color palette for the application.
    ///
    /// This enumeration provides a centralized collection of shadow colors
    /// used to create consistent depth and elevation effects across the UI.
    ///
    /// Example:
    /// ```
    /// view.shadow(color: AppStyle.ShadowColors.shadow, radius: 4)
    /// ```
    public enum ShadowColors {

        /// A standard shadow color with 20% opacity.
        ///
        /// Use this color for creating subtle elevation effects in the UI.
        /// The opacity level is optimized for both light and dark mode.
        public static let primary = Color.gray.opacity(0.2)
    }
}
