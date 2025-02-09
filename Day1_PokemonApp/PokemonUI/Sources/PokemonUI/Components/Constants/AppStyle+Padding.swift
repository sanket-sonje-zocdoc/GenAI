//
//  AppStyle+Padding.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines standardized padding values used throughout the app
    public enum Padding {

        /// Extra-extra-extra small padding (2 points)
        public static let xxxSmall: CGFloat = 2

        /// Extra-extra small padding (4 points)
        public static let xxSmall: CGFloat = 4

        /// Extra small padding (8 points)
        public static let xSmall: CGFloat = 8

        /// Standard padding (16 points)
        public static let normal: CGFloat = 16

        /// Medium padding (32 points)
        public static let medium: CGFloat = 32

        /// Large padding (48 points)
        public static let large: CGFloat = 48

        /// Extra large padding (64 points)
        public static let xLarge: CGFloat = 64

    }
}
