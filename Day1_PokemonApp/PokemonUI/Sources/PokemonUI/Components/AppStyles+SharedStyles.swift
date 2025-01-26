//
//  AppStyles+SharedStyles.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
extension AppStyle {

    /// Shared styles used across different components
    public enum SharedStyles {

        /// Creates a consistent card background style
        /// - Returns: A view modifier that applies the card background styling
        public static func cardBackground() -> some View {
            RoundedRectangle(cornerRadius: Radius.corner)
                .fill(Theme.Colors.background)
                .shadow(
                    color: Colors.shadow,
                    radius: Radius.shadow,
                    x: 0,
                    y: 1
                )
        }

        public static func typeTag(color: Color) -> some View {
            Capsule()
                .fill(color)
                .overlay(
                    Capsule()
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                )
        }
    }
}
