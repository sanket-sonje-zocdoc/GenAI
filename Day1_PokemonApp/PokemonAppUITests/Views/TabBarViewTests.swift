//
//  MainTabViewTests.swift
//  PokemonAppUITests
//
//  Created by AI on 15/03/25.
//

import XCTest

@testable import PokemonApp

final class TabBarViewTests: PokemonBaseViewTests {

    // MARK: - Tests

    func testTabBarExists() throws {
        // Verify that the tab bar exists
        XCTAssertTrue(app.tabBars.firstMatch.exists, "Tab bar should exist")

        // Verify that both tabs are present
        XCTAssertTrue(app.tabBars.buttons["Pokemon"].exists, "Pokemon tab should exist")
        XCTAssertTrue(app.tabBars.buttons["Compare"].exists, "Compare tab should exist")

        // Verify tab bar appearance
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists)
        XCTAssertEqual(tabBar.buttons.count, 2, "Should have exactly 2 tabs")
    }

    func testPokemonTabInitialState() throws {
        // Verify we start on the Pokemon tab
        XCTAssertTrue(app.navigationBars["Pokemons"].exists, "Should start on Pokemon list")

        // Verify search bar exists
        XCTAssertTrue(app.textFields["SearchByName_TextField"].exists, "Search field should exist")

        // Wait for list to load
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Verify list exists and has items
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.exists)
        XCTAssertGreaterThan(list.cells.count, 0)
    }

    func testCompareTabNavigation() throws {
        // Navigate to Compare tab
        app.tabBars.buttons["Compare"].tap()

        // Verify navigation title
        XCTAssertTrue(app.navigationBars["Compare Pokemon"].exists)

        // Verify Pokemon selection views are present
        XCTAssertTrue(app.staticTexts["FirstPokemon_AppText_Text"].exists)
        XCTAssertTrue(app.staticTexts["SecondPokemon_AppText_Text"].exists)

        // Navigate back to Pokemon tab
        app.tabBars.buttons["Pokemon"].tap()

        // Verify we're back on Pokemon list
        XCTAssertTrue(app.navigationBars["Pokemons"].exists)
    }

    func testTabNavigationPreservesState() throws {
        // Start on Pokemon tab and perform a search
        let searchField = app.textFields["SearchByName_TextField"]
        searchField.tap()
        searchField.typeText("bulba")

        // Verify search results
        XCTAssertTrue(app.staticTexts["Bulbasaur"].exists)

        // Switch to Compare tab
        app.tabBars.buttons["Compare"].tap()

        // Perform some action in Compare tab
        defaultSelectionsOfPokemon(
            updatedID: "Bulbasaur"
        )

        // Switch back to Pokemon tab
        app.tabBars.buttons["Pokemon"].tap()

        // Verify search state is preserved
        XCTAssertEqual(searchField.value as? String, "bulba")
        XCTAssertTrue(app.staticTexts["Bulbasaur"].exists)

        // Switch back to Compare tab and verify its state
        app.tabBars.buttons["Compare"].tap()
        XCTAssertTrue(app.staticTexts["Bulbasaur"].exists)
    }
}
