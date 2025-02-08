//
//  View+A11y.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI

/// SwiftUI View extension that provides convenient methods for adding accessibility identifiers
/// to views. These identifiers are essential for UI testing and automation in the Pokemon application.
///
/// The extension provides two main approaches for adding accessibility identifiers:
/// 1. Using component-based identifiers with `a11yID(_:type:)`
/// 2. Using custom identifiers with `customA11yID(_:)`
///
/// Usage Examples:
/// ```
/// // Component-based identifier
/// AppText("Pokemon Name")
///     .a11yID("Label", type: .appText)  // Results in "AppText_Label"
/// ```
///
/// Best Practices:
/// - Use `a11yID(_:type:)` for components from the design system
/// - Use consistent suffixes across similar elements
/// - Keep identifiers meaningful and unique within their context
/// - Use `customA11yID(_:)` only for special cases
public extension View {

    /// Adds an accessibility identifier to the view using a predefined component type.
    ///
    /// This method is the preferred way to add accessibility identifiers to views
    /// that are part of the Pokemon application's design system. It ensures consistent
    /// naming across the application by combining the component type with a suffix.
    ///
    /// - Parameters:
    ///   - suffix: A unique identifier within the component's context (e.g., "Container", "Label", "Icon")
    ///   - type: The type of UI component, defined in `ViewType` (e.g., .appAvatar, .appCard)
    /// - Returns: A view with the accessibility identifier in format "ComponentType_suffix"
    ///
    /// Example Usage:
    /// ```
    /// // In an avatar component
    /// Circle()
    ///     .a11yID("Border", type: .appAvatar)  // Results in "AppAvatar_Border"
    /// ```
    func a11yID(_ suffix: String, type: ViewType) -> some View {
        accessibilityIdentifier("\(type.type)_\(suffix)")
    }

    /// Adds a custom accessibility identifier to the view.
    ///
    /// This method should be used when the standard component-based approach
    /// doesn't fit the use case. It provides complete control over the identifier format.
    ///
    /// - Parameter identifier: A custom, unique identifier for the view
    /// - Returns: A view with the specified accessibility identifier
    ///
    /// Example Usage:
    /// ```
    /// // For unique, one-off elements
    /// Button("Start")
    ///     .customA11yID("welcomeScreen_startButton")
    ///
    /// // For complex composite views
    /// HStack { ... }
    ///     .customA11yID("pokemonList_headerContainer")
    ///
    /// // For dynamic identifiers
    /// Text(pokemon.name)
    ///     .customA11yID("pokemon_\(pokemon.id)_nameLabel")
    /// ```
    ///
    /// - Note: Consider using `a11yID(_:type:)` before resorting to custom identifiers
    ///   to maintain consistency across the application.
    func customA11yID(_ identifier: String) -> some View {
        accessibilityIdentifier(identifier)
    }
}
