//
//  AppTag.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// A reusable pill-shaped tag component that displays text with a colored background.
///
/// `AppTag` is designed to be used for displaying categories, types, or labels in a consistent
/// style across the application. It creates a capsule-shaped container with customizable text
/// and background color.
///
/// The component automatically applies:
/// - A capsule shape for a pill-like appearance
/// - Consistent padding using AppStyle values
/// - White text color for optimal contrast against colored backgrounds
/// - Standardized typography using AppText component
///
/// Example usage:
/// ```
/// // Create a red tag for Fire type
/// AppTag(text: "Fire", color: .red)
///
/// // Create multiple tags in a horizontal stack
/// HStack(spacing: 8) {
///     AppTag(text: "Water", color: .blue)
///     AppTag(text: "Flying", color: .cyan)
/// }
/// ```
///
/// - Note: The component automatically handles text styling and contrast,
///         so you only need to provide the text content and background color.
@available(iOS 15.0, *)
public struct AppTag: View {

    // MARK: - Properties

    /// The text content to be displayed in the tag
    public let text: String

    /// The background color of the tag
    public let color: Color

    // MARK: - Initialization

    /// Creates a new tag with the specified text and background color
    /// - Parameters:
    ///   - text: The string to be displayed inside the tag
    ///   - color: The background color of the tag
    public init(
        text: String, 
        color: Color
    ) {
        self.text = text
        self.color = color
    }

    // MARK: - Body

    public var body: some View {
        AppText(text, style: .caption)
            .padding(.horizontal, AppStyle.Padding.xSmall)
            .padding(.vertical, AppStyle.Padding.xxSmall)
            .background(AppStyle.SharedStyles.typeTag(color: color))
            .foregroundColor(AppStyle.TextColors.primary)
            .clipShape(Capsule())
            .a11yID(text, view: .appTag, component: .container)
    }
}

// MARK: - Previews

@available(iOS 15.0, *)
#Preview {
    VStack(spacing: 16) {
        AppTag(text: "Fire", color: .red)

        HStack(spacing: 8) {
            AppTag(text: "Water", color: .blue)
            AppTag(text: "Grass", color: .green)
            AppTag(text: "Electric", color: .yellow)
        }

        ZStack {
            Color.black.ignoresSafeArea()
            AppTag(text: "Ghost", color: .purple)
        }
        .frame(height: 100)
    }
    .padding()
}
