//
//  PokemonBaseViewTests.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 01/02/25.
//

import XCTest

/// `PokemonBaseViewTests` serves as the base class for UI testing in the Pokemon application.
/// This class provides common setup, teardown, and helper functionality that can be inherited by other test classes.
///
/// Features:
/// - Manages XCUIApplication lifecycle
/// - Provides helper methods for common Pokemon selection scenarios
/// - Handles basic test environment setup and cleanup
///
/// Best Practices:
/// - Always call super.setUp() in overridden setUp methods
/// - Always call super.tearDown() in overridden tearDown methods
/// - Use provided helper methods for consistent Pokemon selection behavior
/// - Add new helper methods here if they're needed across multiple test classes
class PokemonBaseViewTests: XCTestCase {

    // MARK: - Properties

    /// The main application instance used for UI testing.
    /// This property provides access to the application's UI elements and state.
    /// It is automatically initialized in setUp() and cleared in tearDown().
    var app: XCUIApplication!

    // MARK: - Test Lifecycle

    /// Sets up the test environment before each test method.
    ///
    /// This method:
    /// - Calls the superclass's setUp method
    /// - Initializes a new XCUIApplication instance
    /// - Launches the application in the test environment
    ///
    /// - Important: Always call super.setUp() when overriding this method
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    /// Tears down the test environment after each test method.
    ///
    /// This method:
    /// - Calls the superclass's tearDown method
    /// - Releases the application instance
    ///
    /// - Important: Always call super.tearDown() when overriding this method
    override func tearDown() {
        super.tearDown()
        app = nil
    }

    // MARK: - Helper Functions

    /// Selects Pokemon with specified identifiers.
    /// Useful for custom Pokemon selection scenarios.
    ///
    /// - Parameters:
    ///   - initialID: The identifier of the first Pokemon to select
    ///   - updatedID: The identifier of the second Pokemon to select
    func selectPokemon(
        initialID: String,
        updatedID: String
    ) {
        app.buttons[initialID].tap()
        app.buttons[updatedID].tap()
    }

    /// Performs default Pokemon selection using the app's standard selection UI.
    ///
    /// - Parameter updatedID: The identifier of the Pokemon to select
    ///
    /// - Note: This method uses the standard selection button and handles the selection flow
    func defaultSelectionsOfPokemon(
        updatedID: String
    ) {
        app.buttons.matching(identifier: "SelectPokemon_AppText_Text").element(boundBy: 0).tap()
        app.buttons[updatedID].tap()
    }

    /// Selects the same Pokemon twice for comparison.
    /// Useful for testing identical Pokemon comparison scenarios.
    ///
    /// This method:
    /// - Selects Charmander as both the first and second Pokemon
    /// - Uses default selection behavior
    func selectSamePokemons() {
        defaultSelectionsOfPokemon(
            updatedID: "Charmander"
        )

        defaultSelectionsOfPokemon(
            updatedID: "Charmander"
        )
    }

    /// Selects two different Pokemon for comparison.
    /// Useful for testing distinct Pokemon comparison scenarios.
    ///
    /// This method:
    /// - Selects Bulbasaur as the first Pokemon
    /// - Selects Charmander as the second Pokemon
    func selectDistinctPokemons() {
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        defaultSelectionsOfPokemon(
            updatedID: "Charmander"
        )
    }
}
