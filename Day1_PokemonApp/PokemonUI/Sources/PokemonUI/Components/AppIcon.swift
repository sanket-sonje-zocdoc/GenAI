//
//  AppIcon.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI

/// A reusable icon component that provides consistent styling across the application.
///
/// `AppIcon` wraps SwiftUI's `Image` view with system SF Symbols, providing standardized
/// sizing, coloring, and weight configurations. This component ensures visual consistency
/// throughout the application.
///
/// Example usage:
/// ```
/// // Basic usage with default styling
/// AppIcon(imageName: "star.fill")
///
/// // Custom colored icon
/// AppIcon(imageName: "heart.fill", color: .red)
///
/// // Custom sized icon
/// AppIcon(imageName: "bell.fill", size: 24)
/// ```
@available(iOS 15.0, *)
public struct AppIcon: View {

    // MARK: - Properties

    /// The SF Symbols name for the icon
    public let imageName: String

    /// The color of the icon. Defaults to the secondary text color from AppStyle
    public let color: Color

    /// The size of the icon in points. Defaults to the standard icon size from AppStyle
    public let size: CGFloat

    /// The font weight of the icon. Defaults to .medium
    public let fontWeight: Font.Weight

    /// The accessibility identifier prefix for this avatar
    public let accessibilityID: String

    // MARK: - Initialization

    /// Creates a new icon with the specified configuration
    /// - Parameters:
    ///   - imageName: The name of the SF Symbol to display
    ///   - color: The color of the icon. Defaults to AppStyle.TextColors.secondary
    ///   - size: The size of the icon in points. Defaults to AppStyle.Frame.normal.height
    ///   - fontWeight: The font weight of the icon. Defaults to .medium
    ///   - accessibilityID: The accessibility identifier prefix for this avatar.
    public init(
        imageName: String,
        color: Color = AppStyle.TextColors.secondary,
        size: CGFloat = AppStyle.Frame.normal.height,
        fontWeight: Font.Weight = .medium,
        accessibilityID: String
    ) {
        self.imageName = imageName
        self.color = color
        self.size = size
        self.fontWeight = fontWeight
        self.accessibilityID = accessibilityID
    }

    // MARK: - Body

    public var body: some View {
        Image(systemName: imageName)
            .foregroundColor(color)
            .font(.system(size: size, weight: fontWeight))
            .a11yID(accessibilityID, view: .appIcon, component: .image)
    }
}

// MARK: - Preview

@available(iOS 15.0, *)
#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            AppIcon(imageName: "star.fill", accessibilityID: "Star")
            AppIcon(imageName: "heart.fill", color: .red, accessibilityID: "Heart")
            AppIcon(imageName: "bell.fill", size: 24, accessibilityID: "Bell")
        }
        
        HStack(spacing: 20) {
            AppIcon(imageName: "person.fill", color: .blue, size: 32, accessibilityID: "Person")
            AppIcon(imageName: "gear", color: .gray, accessibilityID: "Gear")
            AppIcon(imageName: "bookmark.fill", fontWeight: .bold, accessibilityID: "Bookmark")
        }
    }
    .padding()
}
