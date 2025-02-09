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
        app.buttons["ComparePokemon_AppLabel_Text"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        // Verify first Pokemon selector exists with correct initial state
        let firstPokemonButton = app.buttons.matching(identifier: "SelectPokemon_AppText_Text").element(boundBy: 0)
        XCTAssertTrue(firstPokemonButton.exists, "First Pokemon selector should exist")

        // Verify second Pokemon selector exists with correct initial state
        let secondPokemonButton = app.buttons.matching(identifier: "SelectPokemon_AppText_Text").element(boundBy: 1)
        XCTAssertTrue(secondPokemonButton.exists, "Second Pokemon selector should exist")

        // Verify no Pokemon types are visible initially
        XCTAssertFalse(app.staticTexts["Grass_AppTag_Container"].exists, "Pokemon types should not be visible initially")
        XCTAssertFalse(app.staticTexts["Fire_AppTag_Container"].exists, "Pokemon types should not be visible initially")
    }

    func testPokemonSelection() throws {
        // Select first Pokemon
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        // Verify Pokemon name and types are displayed
        XCTAssertTrue(app.buttons["Bulbasaur_AppText_Text"].exists)
        XCTAssertTrue(app.staticTexts["Grass_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Poison_AppTag_Container"].exists)

        // Select second Pokemon
        defaultSelectionsOfPokemon(
            updatedID: "Charmander"
        )

        // Verify second Pokemon name and type are displayed
        XCTAssertTrue(app.buttons["Charmander_AppText_Text"].exists)
        XCTAssertTrue(app.staticTexts["Fire_AppTag_Container"].exists)
    }

    func testPokemonReSelection() throws {
        // Initial selection
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        // Verify initial selection
        XCTAssertTrue(app.buttons["Bulbasaur_AppText_Text"].exists)
        XCTAssertTrue(app.staticTexts["Grass_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Poison_AppTag_Container"].exists)

        // Change selection
        selectPokemon(
            initialID: "Bulbasaur_AppText_Text",
            updatedID: "Charmander_AppText_Text"
        )

        // Verify updated selection
        XCTAssertTrue(app.buttons["Charmander_AppText_Text"].exists)
        XCTAssertTrue(app.staticTexts["Fire_AppTag_Container"].exists)
        XCTAssertFalse(app.staticTexts["Grass_AppTag_Container"].exists, "Previous Pokemon's types should not be visible")
    }

    func testBothSelectionIndependence() throws {
        // Select two different pokemons Pokemon
        selectDistinctPokemons()

        // Verify both selections maintain their state
        XCTAssertTrue(app.buttons["Bulbasaur_AppText_Text"].exists)
        XCTAssertTrue(app.buttons["Charmander_AppText_Text"].exists)
        XCTAssertTrue(app.staticTexts["Grass_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Poison_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Fire_AppTag_Container"].exists)
    }

    func testPokemonSpriteVisibility() throws {
        // Initially no sprites should be visible
        XCTAssertEqual(app.images.count, 0, "No sprites should be visible initially")

        // Select a Pokemon
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        // Verify sprite appears
        XCTAssertEqual(app.images.count, 1, "Pokemon sprite should be visible after selection")
    }
}
