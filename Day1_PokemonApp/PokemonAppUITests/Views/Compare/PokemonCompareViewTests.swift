//
//  CompareViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class PokemonCompareViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        // Navigate to Compare Pokemon screen and select both Pokemon
        // TODO: Update this test when we are implementing the Tab View
        app.buttons["ComparePokemon_AppLabel_Text"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        // Wait for the view to be fully loaded
        let compareText = app.staticTexts["ComparePokemon_AppText_Text"]
        XCTAssertTrue(compareText.waitForExistence(timeout: 5), "Compare Pokemon text should exist")

        // Check for first Pokemon selector (it's a button)
        let firstPokemonButton = app.buttons.matching(identifier: "SelectPokemon_AppText_Text").element(boundBy: 0)
        XCTAssertTrue(firstPokemonButton.exists, "First Pokemon selector should exist")

        // Check for second Pokemon selector (it's a button)
        let secondPokemonButton = app.buttons.matching(identifier: "SelectPokemon_AppText_Text").element(boundBy: 1)
        XCTAssertTrue(secondPokemonButton.exists, "Second Pokemon selector should exist")

        // Check for initial message
        XCTAssertTrue(app.staticTexts["SelectTwoPokemonToCompareTheirStats_AppText_Text"].exists)
    }

    func testPokemonSelection() throws {
        verifyPokemonSelection()
    }

    func testStatComparison() throws {
        verifyPokemonSelection()

        // Verify stats comparison appears
        XCTAssertTrue(app.staticTexts["StatsComparison_AppText_Text"].exists)

        // Verify stat rows exist
        let statNames = ["Hp", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed"]
        for statName in statNames {
            XCTAssertTrue(app.staticTexts["\(statName)_AppText_Text"].exists)
        }

        // Verify stat values are displayed
        let statValues = app.staticTexts.matching(NSPredicate(format: "label MATCHES %@", "^[0-9]+$"))
        XCTAssertTrue(statValues.count >= 12)
    }

    func testPokemonReSelection() throws {
        // Initial selection
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        XCTAssertTrue(app.staticTexts["Grass_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Poison_AppTag_Container"].exists)

        // Change selection
        selectPokemon(
            initialID: "Bulbasaur_AppText_Text",
            updatedID: "Venusaur_AppText_Text"
        )

        // Verify type tags updated
        XCTAssertTrue(app.staticTexts["Grass_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Poison_AppTag_Container"].exists)
    }

    // MARK: - Private Helper

    private func verifyPokemonSelection() {
        // Select first Pokemon
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        XCTAssertTrue(app.staticTexts["Grass_AppTag_Container"].exists)
        XCTAssertTrue(app.staticTexts["Poison_AppTag_Container"].exists)

        // Select second Pokemon
        defaultSelectionsOfPokemon(
            updatedID: "Charmander"
        )

        XCTAssertTrue(app.staticTexts["Fire_AppTag_Container"].exists)
    }
}
