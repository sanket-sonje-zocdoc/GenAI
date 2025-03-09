//
//  ViewType.swift
//  PokemonUtils
//
//  Created by Sanket Sonje on 08/02/25.
//

import Foundation

/// Represents the different types of UI components in the Pokemon application.
/// This enum is used to generate consistent accessibility identifiers across the app.
///
/// Each case corresponds to a specific UI component and provides a standardized
/// way to create accessibility identifiers for UI testing.
///
/// Example usage:
/// ```
/// // In a UI component
/// Text("Hello")
///     .a11yID("Label", type: .appText)  // Results in "AppText_Label"
/// ```
///
/// - Note:
///   The `type` property returns a string that serves as a prefix for
///   accessibility identifiers. This ensures consistent naming across
///   the application's UI testing infrastructure.
///
/// Available components:
/// - `appAvatar`: Circular image component with loading state
/// - `appCard`: Container component with customizable styling
/// - `appDivider`: Line separator component
/// - `appIcon`: Icon component for displaying system or custom icons
/// - `appLabel`: Text label component with standardized styling
/// - `appPicker`: Selection component for choosing from options
/// - `appProgressBar`: Progress indicator component
/// - `appTag`: Label component for displaying tags or badges
/// - `appText`: Basic text component with standardized styling
public enum ViewType {

    /// Circular image component that can display remote images with loading state
    case appAvatar

    /// Container component that provides consistent card styling with customizable options
    case appCard

    /// Line separator component for visual separation of content
    case appDivider

    /// Component for displaying system or custom icons
    case appIcon

    /// Text label component with standardized styling options
    case appLabel

    /// Selection component that allows choosing from multiple options
    case appPicker

    /// Progress indicator component for showing loading or completion status
    case appProgressBar

    /// Progress indicator spinner component for showing loading or completion status
    case appProgressView

    /// Label component specifically designed for displaying tags or badges
    case appTag

    /// Basic text component with standardized styling options
    case appText

    /// Default case where the App component is not available
    case notPresent

    /// Returns the string representation of the view type.
    /// This string is used as a prefix for accessibility identifiers.
    ///
    /// - Returns: A string that represents the view type (e.g., "AppAvatar", "AppCard")
    ///
    /// Example:
    /// ```
    /// let type = ViewType.appAvatar
    /// print(type.type) // Prints "AppAvatar"
    /// ```
    public var type: String {
        switch self {
        case .appAvatar: return "AppAvatar"
        case .appCard: return "AppCard"
        case .appDivider: return "AppDivider"
        case .appIcon: return "AppIcon"
        case .appLabel: return "AppLabel"
        case .appPicker: return "AppPicker"
        case .appProgressBar: return "AppProgressBar"
        case .appProgressView: return "AppProgressView"
        case .appTag: return "AppTag"
        case .appText: return "AppText"
        case .notPresent: return ""
        }
    }
}
