//
//  AppStyle+StackSpacing.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/02/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines standardized stack spacing values used throughout the app
    public enum StackSpacing {

        /// Extra-extra small stack spacing (4 points)
        public static let xxSmall: CGFloat = 4

        /// Extra small stack spacing (8 points)
        public static let xSmall: CGFloat = 8

        /// Standard stack spacing (16 points)
        public static let normal: CGFloat = 16

        /// Medium stack spacing (32 points)
        public static let medium: CGFloat = 32

        /// Large stack spacing (48 points)
        public static let large: CGFloat = 48

        /// Extra large stack spacing (64 points)
        public static let xLarge: CGFloat = 64

    }
}
