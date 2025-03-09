//
//  PokemonComparisonStatsViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class PokemonComparisonStatsViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        // Navigate to Compare tab and select both Pokemon
        app.tabBars.buttons["Compare"].tap()
        selectDistinctPokemons()
    }

    // MARK: - Tests

    func testStatsComparisonViewExists() throws {
        // Verify the stats comparison title exists
        let statsComparisonTitle = app.staticTexts["StatsComparison_AppText_Text"]
        XCTAssertTrue(statsComparisonTitle.exists, "Stats Comparison title should exist")
    }

    func testAllStatsAreDisplayed() throws {
        // Verify all stat names are displayed
        let expectedStats = ["Hp", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed"]

        for statName in expectedStats {
            let statText = app.staticTexts["\(statName)_AppText_Text"]
            XCTAssertTrue(statText.exists, "\(statName) stat should be displayed")
        }
    }

    func testStatValuesAreDisplayed() throws {
        // Verify stat values are displayed for both Pokemon
        // We're selecting Bulbasaur and Charmander which have known base stats

        // Known base stats for Bulbasaur
        let bulbasaurStats = [45, 49, 49, 65, 65, 45]

        // Known base stats for Charmander
        let charmanderStats = [39, 52, 43, 60, 50, 65]

        // Verify each stat value exists
        for value in bulbasaurStats + charmanderStats {
            let statValue = app.staticTexts["\(value)_AppText_Text"]
            XCTAssertTrue(statValue.exists, "Stat value \(value) should be displayed")
        }
    }

    func testStatComparisonVisibility() throws {
        // Verify that the comparison view becomes visible only after selecting both Pokemon
        selectPokemon(
            initialID: "Bulbasaur_AppText_Text",
            updatedID: "SelectPokemon_AppText_Text"
        )

        // Stats comparison should not be visible with only one Pokemon selected
        XCTAssertFalse(app.staticTexts["StatsComparison_AppText_Text"].exists)

        // Complete the selection
        // Select first Pokemon (Bulbasaur)
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        // Stats comparison should now be visible
        XCTAssertTrue(app.staticTexts["StatsComparison_AppText_Text"].exists)
    }
}
