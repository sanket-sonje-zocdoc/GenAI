//
//  PokemonBaseViewTests.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 01/02/25.
//

import XCTest

/// `PokemonBaseViewTests` serves as the base class for UI testing in the Pokemon application.
/// This class provides common setup and teardown functionality that can be inherited by other test classes.
///
/// The class initializes and manages the `XCUIApplication` instance required for UI testing,
/// handling the basic lifecycle of the test environment.
///
/// Usage:
/// ```
/// class YourPokemonTests: PokemonBaseViewTests {
///     func testSpecificFeature() {
///         // Your test code here
///         // Use self.app to access the application instance
///     }
/// }
/// ```
class PokemonBaseViewTests: XCTestCase {

    // MARK: - Properties

    /// The main application instance used for UI testing.
    /// This property provides access to the application's UI elements and state.
    var app: XCUIApplication!

    // MARK: - Test Lifecycle

    /// Sets up the test environment before each test method.
    ///
    /// This method:
    /// - Calls the superclass's setUp method
    /// - Initializes a new XCUIApplication instance
    /// - Launches the application in the test environment
    override func setUp() {
        super.setUp()

        app = XCUIApplication()
        app.launch()
    }

    /// Tears down the test environment after each test method.
    ///
    /// This method:
    /// - Calls the superclass's tearDown method
    /// - Releases the application instance by setting it to nil
    override func tearDown() {
        super.tearDown()

        app = nil
    }

    func selectSamePokemons() {
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Charmander"
        )

        selectPokemon(
            initialName: "Select Second Pokemon, Select Pokemon",
            updatedName: "Charmander"
        )
    }

    func selectDistinctPokemons() {
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )

        selectPokemon(
            initialName: "Select Second Pokemon, Select Pokemon",
            updatedName: "Charmander"
        )
    }

    func selectPokemon(
        initialName: String,
        updatedName: String
    ) {
        app.buttons[initialName].tap()
        app.buttons[updatedName].tap()
    }
}
