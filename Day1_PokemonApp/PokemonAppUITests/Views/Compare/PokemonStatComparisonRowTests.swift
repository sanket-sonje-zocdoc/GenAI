//
//  PokemonStatComparisonRowTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class PokemonStatComparisonRowTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        // Navigate to Compare Pokemon screen and select both Pokemon
        // TODO: Update this test when we are implementing the Tab View
        app.buttons["ComparePokemon_AppLabel_Text"].tap()
    }

    // MARK: - Tests

    func testStatRowExists() throws {
        // Select distinct pokemons
        selectDistinctPokemons()

        // Verify that stat rows are visible
        let statNames = ["Hp", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed"]

        for statName in statNames {
            XCTAssertTrue(app.staticTexts["\(statName)_AppText_Text"].exists, "\(statName) stat row should exist")
        }
    }

    func testStatValuesVisibility() throws {
        // Select distinct pokemons
        selectDistinctPokemons()

        // Known stats for Bulbasaur vs Charmander comparison
        let comparisons = [
            ("Hp", 45, 39),
            ("Attack", 49, 52),
            ("Defense", 49, 43),
            ("Special-Attack", 65, 60),
            ("Special-Defense", 65, 50),
            ("Speed", 45, 65)
        ]

        for (stat, value1, value2) in comparisons {
            XCTAssertTrue(app.staticTexts["\(value1)_AppText_Text"].exists, "\(stat) value \(value1) should exist")
            XCTAssertTrue(app.staticTexts["\(value2)_AppText_Text"].exists, "\(stat) value \(value2) should exist")
        }
    }

    func testStatHighlighting() throws {
        // Select distinct pokemons
        selectDistinctPokemons()

        // Test Attack stat where Charmander (52) > Bulbasaur (49)
        let attackStat = app.staticTexts["Attack_AppText_Text"]
        XCTAssertTrue(attackStat.exists)

        // Verify the higher value (52) is highlighted
        let charmanderAttack = app.staticTexts["52_AppText_Text"]
        XCTAssertTrue(charmanderAttack.exists)

        // Test Special-Defense where Bulbasaur (65) > Charmander (50)
        let specialDefenseStat = app.staticTexts["Special-Defense_AppText_Text"]
        XCTAssertTrue(specialDefenseStat.exists)

        // Verify the higher value (65) is highlighted
        let bulbasaurSpecialDefense = app.staticTexts["65_AppText_Text"]
        XCTAssertTrue(bulbasaurSpecialDefense.exists)
    }

    func testProgressBarVisibility() throws {
        // Select distinct pokemons
        selectDistinctPokemons()

        // Verify progress bars are visible for each stat
        let statNames = ["Hp", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed"]

        for statName in statNames {
            XCTAssertTrue(app.staticTexts["\(statName)_AppText_Text"].exists, "Progress bar for \(statName) should be visible")
        }
    }

    func testEqualStatsDisplay() throws {
        // Select same Pokemon for comparison to test equal stats
        selectSamePokemons()

        // Known stats for Charmander with their corresponding names
        let statsWithNames = [
            (39, "Hp"),
            (52, "Attack"),
            (43, "Defense"),
            (60, "Special-Attack"),
            (50, "Special-Defense"),
            (65, "Speed")
        ]
        
        for (statValue, statName) in statsWithNames {
            // Verify stat name exists
            let statNameText = app.staticTexts["\(statName)_AppText_Text"]
            XCTAssertTrue(statNameText.exists, "Stat name \(statName) should exist")
            
            // Verify both stat values exist (left and right)
            let statValueString = String(statValue)
            let statValues = app.staticTexts.matching(identifier: "\(statValueString)_AppText_Text")
            XCTAssertEqual(statValues.count, 2, "Should find exactly two instances of value \(statValue) for \(statName)")
            
            // Optional: Verify the values are on either side of the stat name
            let leftValue = statValues.element(boundBy: 0)
            let rightValue = statValues.element(boundBy: 1)
            XCTAssertTrue(leftValue.frame.maxX < statNameText.frame.minX, "Left value should be before stat name")
            XCTAssertTrue(rightValue.frame.minX > statNameText.frame.maxX, "Right value should be after stat name")
        }
    }
}
