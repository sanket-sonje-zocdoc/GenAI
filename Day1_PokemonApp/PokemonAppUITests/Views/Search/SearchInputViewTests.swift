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
        XCTAssertTrue(app.images["MagnifyingGlass_AppIcon_Image"].exists, "Search icon should exist")
        XCTAssertTrue(app.textFields["SearchByName_TextField"].exists, "Search field should exist")
        XCTAssertTrue(app.images["SortingOptionsByNameOrType_AppIcon_Image"].exists, "Search mode button should exist")
        XCTAssertTrue(app.buttons["SortingOptions_AppIcon_Image"].exists, "Sort button should exist")

        // Verify clear button is not visible initially
        XCTAssertFalse(app.buttons["Close_AppIcon_Image"].exists, "Clear button should not be visible initially")
    }

    func testClearButtonBehavior() throws {
        // Enter search text
        let searchField = app.textFields["SearchByName_TextField"]
        searchField.tap()
        searchField.typeText("Test")

        // Verify clear button appears
        let clearButton = app.buttons["Close_AppIcon_Image"]
        XCTAssertTrue(clearButton.exists, "Clear button should appear with text")

        // Clear text
        clearButton.tap()
        XCTAssertEqual(searchField.value as? String, "Search By Name", "Search field should be cleared")
        XCTAssertFalse(clearButton.exists, "Clear button should disappear after clearing")
    }

    func testSortBadgeBehavior() throws {
        // Add sort criteria
        app.buttons["SortingOptions_AppIcon_Image"].tap()
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Verify badge appears
        XCTAssertTrue(app.staticTexts["1_AppText_Text"].exists, "Sort badge should show count")

        // Clear via main clear button
        let closeButtons = app.buttons.matching(identifier: "Close_AppIcon_Image")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()
        XCTAssertFalse(app.staticTexts["1_AppText_Text"].exists, "Sort badge should disappear after clearing")
    }
}
