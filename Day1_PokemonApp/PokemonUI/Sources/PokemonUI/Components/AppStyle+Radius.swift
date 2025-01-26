//
//  AppStyle+Radius.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 18.0, *)
extension AppStyle {

    /// `Radius` namespace contains all corner radius and shadow radius constants used throughout the app.
    /// This ensures consistent rounded corners and shadow effects across all UI components.
    public enum Radius {

        /// The standard corner radius used for UI elements like cards, buttons, and other components
        /// that require rounded corners.
        public static let corner: CGFloat = 10

        /// The standard shadow radius used for elevation effects in the app.
        /// This defines how far the shadow spreads from the UI element.
        public static let shadow: CGFloat = 2

    }
}
