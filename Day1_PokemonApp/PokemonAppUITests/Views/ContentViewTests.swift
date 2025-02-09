//
//  ContentViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class ContentViewTests: PokemonBaseViewTests {

    // MARK: - Tests

    func testInitialState() throws {
        // Verify navigation title
        XCTAssertTrue(app.navigationBars["Pokemons"].exists)

        // Verify search bar exists
        XCTAssertTrue(app.textFields["SearchByName_TextField"].exists, "Search field should exist")

        // Verify Compare Pokemon button exists
        XCTAssertTrue(app.buttons["Compare Pokemon"].exists)
    }

    func testPokemonListLoading() throws {
        // Wait for list to load (progress view should disappear)
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Verify list contains Pokemon
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.exists)
        XCTAssertGreaterThan(list.cells.count, 0)
    }

    func testPokemonSearch() throws {
        // Wait for list to load
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Enter search text
        let searchField = app.textFields["SearchByName_TextField"]
        searchField.tap()
        searchField.typeText("bulba")

        // Verify filtered results
        XCTAssertTrue(app.staticTexts["Bulbasaur"].exists)
    }

    func testNavigationToPokemonDetail() throws {
        // Wait for list to load
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Tap on first Pokemon
        app.collectionViews.cells.firstMatch.tap()

        // Verify navigation to detail view
        XCTAssertTrue(app.navigationBars["Pokemon Details"].exists)
    }
}
