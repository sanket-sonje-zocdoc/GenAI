//
//  AppCard.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI

import PokemonUtils

/// A custom card component that provides consistent styling across the app.
/// Use this component to create either flat or elevated cards with customizable
/// corner radius, padding, and border options.
///
/// Example usage:
/// ```
/// AppCard(style: .elevated) {
///     Text("Card Content")
/// }
/// ```
public struct AppCard<Content: View>: View {

    // MARK: - Properties

    private let style: AppCardStyle
    private let content: Content
    private let cornerRadius: CGFloat
    private let padding: CGFloat
    private let showBorder: Bool

    // MARK: - Initialization

    /// Creates a new AppCard instance
    /// - Parameters:
    ///   - style: The style of the card (flat or elevated)
    ///   - cornerRadius: The corner radius of the card (defaults to 12)
    ///   - padding: The padding inside the card (defaults to 16)
    ///   - showBorder: Whether to show a border around the card (defaults to true)
    ///   - content: The content to be displayed inside the card
    public init(
        style: AppCardStyle = .flat,
        cornerRadius: CGFloat = AppStyle.Radius.corner,
        padding: CGFloat = AppStyle.Padding.xSmall,
        showBorder: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.showBorder = showBorder
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        content
            .padding(padding)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        AppStyle.Colors.shadow,
                        lineWidth: showBorder ? 1.5 : 0
                    )
                    .a11yID("RoundedRectangle", type: .appCard)
            )
            .shadow(
                color: Color.black.opacity(style.shadowOpacity),
                radius: style.shadowRadius,
                x: 0,
                y: 0
            )
            .a11yID("Container", type: .appCard)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        AppCard(style: .flat) {
            Text("Flat Card")
        }

        AppCard(style: .elevated) {
            Text("Elevated Card")
        }

        AppCard(
            style: .elevated,
            cornerRadius: 20,
            padding: 24
        ) {
            Text("Custom Card")
        }
    }
    .padding()
}
