//
//  AppStyle+FontSize.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/02/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines standardized font size values used throughout the app
    public enum FontSize {

        // MARK: - Frame Sizes

        /// Extra-extra small font size (4 points)
        public static let xxSmall: CGFloat = 4

        /// Extra small font size (8 points)
        public static let xSmall: CGFloat = 8

        /// Normal font size (12 points)
        public static let normal: CGFloat = 12

        /// Medium font size (16 points)
        public static let medium: CGFloat = 16

        /// Large font size (20 points)
        public static let large: CGFloat = 20

        /// Extra large font size (24 points)
        public static let xLarge: CGFloat = 24

    }
}
