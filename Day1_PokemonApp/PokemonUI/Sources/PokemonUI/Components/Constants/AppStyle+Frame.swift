//
//  AppStyle+Frame.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/02/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Defines standardized frame sizes used throughout the app
    public enum Frame {

        // MARK: - Frame Sizes

        /// Extra-extra-extra small frame of size (1, 1)
        public static let xxxSmall = CGSize(width: 1, height: 1)

        /// Extra-extra small frame of size (4, 4)
        public static let xxSmall = CGSize(width: 4, height: 4)

        /// Extra small frame of size (8, 8)
        public static let xSmall = CGSize(width: 8, height: 8)

        /// Normal frame of size (16, 16)
        public static let normal = CGSize(width: 16, height: 16)

        /// Standard frame of size (16, 16)
        public static let standard = CGSize(width: 24, height: 24)

        /// Medium frame of size (32, 32)
        public static let medium = CGSize(width: 32, height: 32)

        /// Large frame of size (48, 48)
        public static let large = CGSize(width: 48, height: 48)

        /// Extra large frame of size (64, 64)
        public static let xLarge = CGSize(width: 64, height: 64)

        /// Frame for progress bar of size (100, 100)
        public static let progressBar = CGSize(width: 100, height: 8)

        /// Extra-extra large frame of size (128, 128)
        public static let xxLarge = CGSize(width: 128, height: 128)

    }
}
