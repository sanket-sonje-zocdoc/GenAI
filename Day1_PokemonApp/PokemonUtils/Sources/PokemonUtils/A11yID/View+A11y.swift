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
/// // In a UI component
/// Image(uiImage: image)
///     .a11yID("Pikachu", view: .image, component: .image)  // Results in "Pikachu_AppAvatar_Image"
/// ```
///
/// Best Practices:
/// - Use `a11yID(_:type:)` for components from the design system
/// - Use consistent suffixes across similar elements
/// - Keep identifiers meaningful and unique within their context
/// - Use `customA11yID(_:)` only for special cases
public extension View {

    /// Adds an accessibility identifier to the view using a predefined component type and view type.
    ///
    /// - Parameters:
    ///   - id: The custom identifier prefix
    ///   - component: The type of SwiftUI component
    ///   - type: The type of UI component from ViewType
    /// - Returns: A view with the accessibility identifier in format "id_ViewType_ComponentType"
    func a11yID(_ id: String, view: ViewType, component: ComponentType) -> some View {
        let modifiedID = id.capitalized.replacingOccurrences(of: " ", with: "")
        let viewType = view.type
        let componentType = component.type
        let a11yID = "\(modifiedID.isEmpty ? "" : "\(modifiedID)")\(viewType.isEmpty ? "" : "_\(viewType)")\(componentType.isEmpty ? "" : "_\(componentType)")"
        return accessibilityIdentifier(a11yID)
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
    /// - Note: Consider using `a11yID(_:type:)` before resorting to custom identifiers
    ///   to maintain consistency across the application.
    func customA11yID(_ identifier: String) -> some View {
        accessibilityIdentifier(identifier)
    }
}
