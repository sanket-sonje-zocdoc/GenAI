//
//  PokemonUIUnitTestCase.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 29/01/25.
//

import XCTest
import SwiftUI

/// Base test case class for Pokemon UI tests
///
/// This class provides common functionality and helper methods for testing SwiftUI views
/// in the Pokemon application. It runs on the main actor to ensure UI-related operations
/// are performed on the main thread.
///
/// Usage:
/// ```
/// class MyPokemonTests: PokemonUIUnitTestCase {
///     func testMyView() {
///         // Your test implementation
///     }
/// }
/// ```
@MainActor
class PokemonUIUnitTestCase: XCTestCase {

    // MARK: - Helper Methods
    
    /// Helper function to find specific view type in view hierarchy
    /// - Parameter mirror: Mirror instance of the view to search in
    /// - Returns: Optional value of requested type if found in view hierarchy
    ///
    /// Example:
    /// ```
    /// let mirror = Mirror(reflecting: myView)
    /// if let textField: TextField<Text> = findView(in: mirror) {
    ///     // Work with the found TextField
    /// }
    /// ```
    func findView<T>(in mirror: Mirror) -> T? {
        for child in mirror.children {
            if let view = child.value as? T {
                return view
            }
            
            // Recursively check child views
            let childMirror = Mirror(reflecting: child.value)
            if let found: T = findView(in: childMirror) {
                return found
            }
        }
        return nil
    }
} 
