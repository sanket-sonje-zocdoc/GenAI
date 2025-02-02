//
//  View+A11y.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

/// SwiftUI View extension that provides convenient methods for adding accessibility identifiers
/// to views. These identifiers are particularly useful for UI testing and automation.
///
/// Usage Example:
/// ```
/// Text("Hello")
///     .a11yID("greeting", type: HomeView.self) // Results in "HomeView_greeting"
///
/// Button("Submit")
///     .customA11yID("submitButton") // Sets "submitButton" directly
/// ```

import SwiftUI

public extension View {

    /// Adds accessibility identifier to the view using the provided view type name as prefix.
    /// This method is particularly useful when you want to namespace your accessibility identifiers
    /// based on the parent view type.
    ///
    /// - Parameters:
    ///   - suffix: Suffix to be added after type name. This should be a unique identifier within the context.
    ///   - type: The type whose name should be used as prefix. Usually the parent view type.
    /// - Returns: Modified view with accessibility identifier in format "TypeName_suffix"
    ///
    /// Example:
    /// ```
    /// Text("Welcome")
    ///     .a11yID("welcomeText", type: LoginView.self) // Results in "LoginView_welcomeText"
    /// ```
    func a11yID<T>(_ suffix: String, type: T.Type) -> some View {
        let typeName = String(describing: type)
        return accessibilityIdentifier("\(typeName)_\(suffix)")
    }

    /// Adds custom accessibility identifier to the view.
    /// Use this method when you need complete control over the identifier format.
    ///
    /// - Parameter identifier: Custom identifier to be set. Should be unique within the app context.
    /// - Returns: Modified view with custom accessibility identifier
    ///
    /// Example:
    /// ```
    /// Button("Login")
    ///     .customA11yID("loginButton_primary")
    /// ```
    func customA11yID(_ identifier: String) -> some View {
        accessibilityIdentifier(identifier)
    }
}
