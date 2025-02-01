//
//  PokemonUtilsUnitTestCase.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 02/01/25.
//

import XCTest
import SwiftUI

/// Base test case class for Pokemon Utils tests
///
/// This class provides common functionality and helper methods for testing SwiftUI views
/// in the Pokemon application. It runs on the main actor to ensure UI-related operations
/// are performed on the main thread.
///
/// Usage:
/// ```
/// class MyPokemonTests: PokemonUtilsUnitTestCase {
///     func testMyView() {
///         // Your test implementation
///     }
/// }
/// ```
@MainActor
class PokemonUtilsUnitTestCase: XCTestCase {

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

    /// Waits for the specified test expectations to be fulfilled
    ///
    /// This helper method provides a convenient way to wait for asynchronous operations
    /// to complete during testing. It wraps XCTest's `fulfillment(of:timeout:)` method
    /// with a default timeout value.
    ///
    /// - Parameters:
    ///   - expectations: An array of `XCTestExpectation` objects to wait for
    ///   - timeout: The maximum time to wait for expectations to be fulfilled (defaults to 10 seconds)
    ///
    /// Example:
    /// ```
    /// let expectation = XCTestExpectation(description: "Async operation")
    /// someAsyncOperation {
    ///     expectation.fulfill()
    /// }
    /// await wait(for: [expectation])
    /// ```
    func wait(for expectations: [XCTestExpectation], timeout: TimeInterval = 10) async {
        await fulfillment(of: expectations, timeout: timeout)
    }
}
