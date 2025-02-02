//
//  PokemonSelectionViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class PokemonSelectionViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        // Navigate to Compare Pokemon screen and select both Pokemon
        // TODO: Update this test when we are implementing the Tab View
        app.buttons["Compare Pokemon"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        // Verify first Pokemon selector exists with correct initial state
        let firstPokemonButton = app.buttons["Select First Pokemon, Select Pokemon"]
        XCTAssertTrue(firstPokemonButton.exists, "First Pokemon selector should exist")

        // Verify second Pokemon selector exists with correct initial state
        let secondPokemonButton = app.buttons["Select Second Pokemon, Select Pokemon"]
        XCTAssertTrue(secondPokemonButton.exists, "Second Pokemon selector should exist")

        // Verify no Pokemon types are visible initially
        XCTAssertFalse(app.staticTexts["Grass"].exists, "Pokemon types should not be visible initially")
        XCTAssertFalse(app.staticTexts["Fire"].exists, "Pokemon types should not be visible initially")
    }

    func testPokemonSelection() throws {
        // Select first Pokemon
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )

        // Verify Pokemon name and types are displayed
        XCTAssertTrue(app.buttons["Select First Pokemon, Bulbasaur"].exists)
        XCTAssertTrue(app.staticTexts["Grass"].exists)
        XCTAssertTrue(app.staticTexts["Poison"].exists)

        // Select second Pokemon
        selectPokemon(
            initialName: "Select Second Pokemon, Select Pokemon",
            updatedName: "Charmander"
        )

        // Verify second Pokemon name and type are displayed
        XCTAssertTrue(app.buttons["Select Second Pokemon, Charmander"].exists)
        XCTAssertTrue(app.staticTexts["Fire"].exists)
    }

    func testPokemonReSelection() throws {
        // Initial selection
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )

        // Verify initial selection
        XCTAssertTrue(app.buttons["Select First Pokemon, Bulbasaur"].exists)
        XCTAssertTrue(app.staticTexts["Grass"].exists)
        XCTAssertTrue(app.staticTexts["Poison"].exists)

        // Change selection
        selectPokemon(
            initialName: "Select First Pokemon, Bulbasaur",
            updatedName: "Charmander"
        )

        // Verify updated selection
        XCTAssertTrue(app.buttons["Select First Pokemon, Charmander"].exists)
        XCTAssertTrue(app.staticTexts["Fire"].exists)
        XCTAssertFalse(app.staticTexts["Grass"].exists, "Previous Pokemon's types should not be visible")
    }

    func testBothSelectionIndependence() throws {
        // Select first Pokemon
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )

        // Select second Pokemon
        selectPokemon(
            initialName: "Select Second Pokemon, Select Pokemon",
            updatedName: "Charmander"
        )

        // Verify both selections maintain their state
        XCTAssertTrue(app.buttons["Select First Pokemon, Bulbasaur"].exists)
        XCTAssertTrue(app.buttons["Select Second Pokemon, Charmander"].exists)
        XCTAssertTrue(app.staticTexts["Grass"].exists)
        XCTAssertTrue(app.staticTexts["Poison"].exists)
        XCTAssertTrue(app.staticTexts["Fire"].exists)
    }

    func testPokemonSpriteVisibility() throws {
        // Initially no sprites should be visible
        XCTAssertEqual(app.images.count, 0, "No sprites should be visible initially")

        // Select a Pokemon
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )

        // Verify sprite appears
        XCTAssertGreaterThan(app.images.count, 0, "Pokemon sprite should be visible after selection")
    }
}
