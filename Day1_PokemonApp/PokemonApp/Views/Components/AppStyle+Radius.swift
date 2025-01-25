//
//  AppStyle+Radius.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

extension AppStyle {

    /// `Radius` namespace contains all corner radius and shadow radius constants used throughout the app.
    /// This ensures consistent rounded corners and shadow effects across all UI components.
    enum Radius {

        /// The standard corner radius used for UI elements like cards, buttons, and other components
        /// that require rounded corners.
        static let corner: CGFloat = 10
        
        /// The standard shadow radius used for elevation effects in the app.
        /// This defines how far the shadow spreads from the UI element.
        static let shadow: CGFloat = 2

    }
}
