//
//  SearchInputViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class SearchInputViewTests: PokemonBaseViewTests {

    // MARK: - Tests

    func testInitialState() throws {
        // Verify search components exist
        XCTAssertTrue(app.images["magnifyingglass"].exists, "Search icon should exist")
        XCTAssertTrue(app.textFields["Search by name"].exists, "Search field should exist")
        XCTAssertTrue(app.images["line.3.horizontal.decrease.circle"].exists, "Search mode button should exist")
        XCTAssertTrue(app.buttons["arrow.up.arrow.down"].exists, "Sort button should exist")

        // Verify clear button is not visible initially
        XCTAssertFalse(app.buttons["xmark.circle.fill"].exists, "Clear button should not be visible initially")
    }

    func testClearButtonBehavior() throws {
        // Enter search text
        let searchField = app.textFields["Search by name"]
        searchField.tap()
        searchField.typeText("Test")

        // Verify clear button appears
        let clearButton = app.buttons["xmark.circle.fill"]
        XCTAssertTrue(clearButton.exists, "Clear button should appear with text")

        // Clear text
        clearButton.tap()
        XCTAssertEqual(searchField.value as? String, "Search by name", "Search field should be cleared")
        XCTAssertFalse(clearButton.exists, "Clear button should disappear after clearing")
    }

    func testSortBadgeBehavior() throws {
        // Add sort criteria
        app.buttons["arrow.up.arrow.down"].tap()
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()

        // Verify badge appears
        XCTAssertTrue(app.staticTexts["1"].exists, "Sort badge should show count")

        // Clear via main clear button
        let closeButtons = app.buttons.matching(identifier: "xmark.circle.fill")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()
        XCTAssertFalse(app.staticTexts["1"].exists, "Sort badge should disappear after clearing")
    }
}
