//
//  SearchBarTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class SearchBarTests: PokemonBaseViewTests {

    // MARK: - Tests

    func testInitialState() throws {
        // Verify search field exists
        let searchField = app.textFields["Search by name"]
        XCTAssertTrue(searchField.exists, "Search field should exist")

        // Verify search mode image exists
        let searchModeImage = app.images["line.3.horizontal.decrease.circle"]
        XCTAssertTrue(searchModeImage.exists, "Search mode button should exist")

        // Verify sort button exists
        let sortButton = app.buttons["arrow.up.arrow.down"]
        XCTAssertTrue(sortButton.exists, "Sort button should exist")

        // Verify clear button is not visible initially
        let clearButton = app.buttons["xmark.circle.fill"]
        XCTAssertFalse(clearButton.exists, "Clear button should not be visible initially")
    }

    func testSearchInput() throws {
        let searchField = app.textFields["Search by name"]

        // Enter search text
        searchField.tap()
        searchField.typeText("Pikachu")

        // Verify clear button appears
        let clearButton = app.buttons["xmark.circle.fill"]
        XCTAssertTrue(clearButton.exists, "Clear button should appear when text is entered")

        // Clear text
        clearButton.tap()
        XCTAssertEqual(searchField.value as? String, "Search by name", "Search field should have `Search by name` text after clearing")
        XCTAssertFalse(clearButton.exists, "Clear button should disappear after clearing")
    }

    func testSearchModeToggle() throws {
        // Tap search mode button
        let searchModeImage = app.images["line.3.horizontal.decrease.circle"]
        searchModeImage.tap()

        // Verify mode options appear
        let nameOption = app.buttons["Search by Name"]
        let typeOption = app.buttons["Search by Type"]
        XCTAssertTrue(nameOption.exists, "Name search option should exist")
        XCTAssertTrue(typeOption.exists, "Type search option should exist")

        // Switch to type search
        typeOption.tap()
        let searchField = app.textFields["Search by type"]
        XCTAssertTrue(searchField.exists, "Search field should update placeholder for type search")
    }

    func testSortingControls() throws {
        // Tap sort button
        let sortButton = app.buttons["arrow.up.arrow.down"]
        sortButton.tap()

        // Verify sort controls appear
        XCTAssertTrue(app.staticTexts["Sort Options"].exists, "Sort options title should appear")

        // Add a sort criteria
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()

        // Verify sort badge appears
        XCTAssertTrue(app.staticTexts["1"].exists, "Sort badge should show count of 1")

        // Clear sorting
        let closeButtons = app.buttons.matching(identifier: "xmark.circle.fill")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()
        XCTAssertFalse(app.staticTexts["1"].exists, "Sort badge should disappear after clearing")
    }
}
