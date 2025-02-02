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
        app.buttons["Compare Pokemon"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        // Wait for the view to be fully loaded
        let compareText = app.staticTexts["Compare Pokemon"]
        XCTAssertTrue(compareText.waitForExistence(timeout: 5), "Compare Pokemon text should exist")

        // Check for first Pokemon selector (it's a button)
        let firstPokemonButton = app.buttons["Select First Pokemon, Select Pokemon"]
        XCTAssertTrue(firstPokemonButton.exists, "First Pokemon selector should exist")

        // Check for second Pokemon selector (it's a button)
        let secondPokemonButton = app.buttons["Select Second Pokemon, Select Pokemon"]
        XCTAssertTrue(secondPokemonButton.exists, "Second Pokemon selector should exist")

        // Check for initial message
        XCTAssertTrue(app.staticTexts["Select two Pokemon to compare their stats"].exists)
    }

    func testPokemonSelection() throws {
        verifyPokemonSelection()
    }

    func testStatComparison() throws {
        verifyPokemonSelection()

        // Verify stats comparison appears
        XCTAssertTrue(app.staticTexts["Stats Comparison"].exists)

        // Verify stat rows exist
        let statNames = ["Hp", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed"]
        for statName in statNames {
            XCTAssertTrue(app.staticTexts[statName].exists)
        }

        // Verify stat values are displayed
        let statValues = app.staticTexts.matching(NSPredicate(format: "label MATCHES %@", "^[0-9]+$"))
        XCTAssertTrue(statValues.count >= 12) // 6 stats × 2 Pokemon
    }

    func testPokemonReSelection() throws {
        // Initial selection
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )
        XCTAssertTrue(app.staticTexts["Grass"].exists)
        XCTAssertTrue(app.staticTexts["Poison"].exists)

        // Change selection
        selectPokemon(
            initialName: "Select First Pokemon, Bulbasaur",
            updatedName: "Venusaur"
        )

        // Verify type tags updated
        XCTAssertTrue(app.staticTexts["Grass"].exists)
        XCTAssertTrue(app.staticTexts["Poison"].exists)
    }

    // MARK: - Private Helper

    private func verifyPokemonSelection() {
        // Select first Pokemon
        selectPokemon(
            initialName: "Select First Pokemon, Select Pokemon",
            updatedName: "Bulbasaur"
        )
        XCTAssertTrue(app.staticTexts["Grass"].exists)
        XCTAssertTrue(app.staticTexts["Poison"].exists)

        // Select first Pokemon
        selectPokemon(
            initialName: "Select Second Pokemon, Select Pokemon",
            updatedName: "Charmander"
        )
        XCTAssertTrue(app.staticTexts["Fire"].exists)
    }
}
