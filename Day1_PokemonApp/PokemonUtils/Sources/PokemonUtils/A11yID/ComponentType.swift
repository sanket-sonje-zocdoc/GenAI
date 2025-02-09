//
//  ComponentType.swift
//  PokemonUtils
//
//  Created by Sanket Sonje on 08/02/25.
//

import Foundation

/// Represents the different types of SwiftUI components used in the Pokemon application.
/// This enum is used to generate consistent accessibility identifiers for basic SwiftUI components.
///
/// Each case corresponds to a basic SwiftUI component and provides a standardized
/// way to create accessibility identifiers for UI testing.
///
/// Example usage:
/// ```
/// // In a UI component
/// Image(uiImage: image)
///     .a11yID("Pikachu", view: .image, component: .image)  // Results in "Pikachu_AppAvatar_Image"
/// ```
///
/// - Note:
///   The `type` property returns a string that serves as a component identifier.
///   This ensures consistent naming across the application's UI testing infrastructure.
///
/// Available components:
/// - `image`: SwiftUI Image component
/// - `text`: SwiftUI Text component
/// - `progressView`: SwiftUI ProgressView component
/// - `rectangle`: SwiftUI Rectangle component
/// - `circle`: SwiftUI Circle component
/// - `capsule`: SwiftUI Capsule component
/// - `container`: Generic container views (VStack, HStack, etc.)
/// - `border`: Border or stroke overlays
/// - `icon`: System or custom icons
public enum ComponentType {

    /// SwiftUI Image component
    case image

    /// SwiftUI Text component
    case text

    /// SwiftUI ProgressView component
    case progressView

    /// SwiftUI Rectangle component
    case rectangle

    /// SwiftUI RoundedRectangle component
    case roundedRectangle

    /// SwiftUI Circle component
    case circle

    /// SwiftUI Capsule component
    case capsule

    /// Generic container views (VStack, HStack, etc.)
    case container

    /// Border or stroke overlays
    case border

    /// System or custom icons
    case icon

    /// System text field
    case textField

    /// Returns the string representation of the component type.
    /// This string is used as a part of accessibility identifiers.
    ///
    /// - Returns: A string that represents the component type (e.g., "Image", "Text")
    ///
    /// Example:
    /// ```
    /// let type = ComponentType.image
    /// print(type.type) // Prints "Image"
    /// ```
    public var type: String {
        switch self {
        case .image: return "Image"
        case .text: return "Text"
        case .progressView: return "ProgressView"
        case .rectangle: return "Rectangle"
        case .roundedRectangle: return "RoundedRectangle"
        case .circle: return "Circle"
        case .capsule: return "Capsule"
        case .container: return "Container"
        case .border: return "Border"
        case .icon: return "Icon"
        case .textField: return "TextField"
        }
    }
}
