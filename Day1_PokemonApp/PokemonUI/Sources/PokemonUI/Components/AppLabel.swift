//
//  AppLabel.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 29/01/25.
//

import SwiftUI

/// A styled label component that combines an icon and text.
///
/// `AppLabel` provides a consistent way to display a label with an icon throughout the app.
/// It automatically applies the app's styling guidelines and supports different text styles.
///
/// Example usage:
/// ```
/// AppLabel("Search", systemImage: "magnifyingglass")
/// AppLabel("Important", style: .title, systemImage: "star.fill")
/// ```
///
/// Features:
/// - Consistent styling with the app's design system
/// - Support for SF Symbols as icons
/// - Customizable text styles
/// - Automatic color coordination between text and icon
///
/// The component uses `AppText` for text rendering and `AppIcon` for the icon,
/// ensuring consistency with other UI components.
public struct AppLabel: View {
    // MARK: - Properties

    /// The text to display in the label
    public let title: String

    /// The SF Symbol name to use as the icon
    public let systemImage: String

    /// The text style that determines the appearance of the label
    public let style: AppTextStyle

    // MARK: - Initialization

    /// Creates a new AppLabel with the specified title and system image.
    /// - Parameters:
    ///   - title: The text to display in the label
    ///   - style: The text style to apply to the label (default: .body)
    ///   - systemImage: The name of the SF Symbol to use as the icon
    ///
    /// Example:
    /// ```
    /// AppLabel(
    ///     "Search",
    ///     style: .body,
    ///     systemImage: "magnifyingglass"
    /// )
    /// ```
    public init(
        _ title: String,
        style: AppTextStyle = .body,
        systemImage: String
    ) {
        self.title = title
        self.style = style
        self.systemImage = systemImage
    }

    // MARK: - Body

    /// The view's body, combining an icon and text with consistent styling
    public var body: some View {
        Label {
            AppText(title, style: style)
                .a11yID(title, view: .appLabel, component: .text)
        } icon: {
            AppIcon(
                systemName: systemImage,
                color: style.color,
                accessibilityID: title
            )
        }
        .font(style.font)
        .foregroundColor(style.color)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        AppLabel("Search by Name", systemImage: "magnifyingglass")
        AppLabel("Filter Results", systemImage: "line.3.horizontal.decrease.circle")
        AppLabel("Sort Items", systemImage: "arrow.up.arrow.down")
    }
    .padding()
}
