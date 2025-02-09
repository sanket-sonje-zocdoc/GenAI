//
//  AppStyle+Frame.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/02/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines standardized line width sizes used throughout the app
    public enum LineWidth {

        // MARK: - Frame Sizes

        /// No line width (0 points)
        public static let zero: CGFloat = 0

        /// Extra-extra-extra small line width (1 points)
        public static let xxxSmall: CGFloat = 1

        /// Extra-extra small line width (2 points)
        public static let xxSmall: CGFloat = 2

        /// Extra small line width (4 points)
        public static let xSmall: CGFloat = 4

        /// Standard line width (6 points)
        public static let normal: CGFloat = 6

        /// Medium line width (8 points)
        public static let medium: CGFloat = 8

        /// Large line width (10 points)
        public static let large: CGFloat = 10

    }
}
