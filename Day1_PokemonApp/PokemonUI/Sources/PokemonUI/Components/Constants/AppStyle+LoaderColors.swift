//
//  AppStyle+Colors.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines the color palette for loading indicators and progress elements in the application.
    /// This enumeration provides a centralized collection of colors specifically designed for
    /// loaders to maintain visual consistency across the app.
    ///
    /// Usage:
    /// ```
    /// view.foregroundColor = AppStyle.LoaderColors.primary
    /// ```
    ///
    /// Features:
    /// - Consistent loader color scheme
    /// - Optimized for visibility and user feedback
    /// - Supports accessibility standards
    public enum LoaderColors {

        /// Primary color for loaders and progress indicators
        ///
        /// Ideal for:
        /// - Loading spinners
        /// - Progress bars
        /// - Activity indicators
        public static let primary = Color.black

    }
}
