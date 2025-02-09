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
        let searchField = app.textFields["SearchByName_TextField"]
        XCTAssertTrue(searchField.exists, "Search field should exist")

        // Verify search mode image exists
        let searchModeImage = app.images["MagnifyingGlass_AppIcon_Image"]
        XCTAssertTrue(searchModeImage.exists, "Search mode button should exist")

        // Verify sort button exists
        let sortButton = app.buttons["SortingOptions_AppIcon_Image"]
        XCTAssertTrue(sortButton.exists, "Sort button should exist")

        // Verify clear button is not visible initially
        let clearButton = app.buttons["Close_AppIcon_Image"]
        XCTAssertFalse(clearButton.exists, "Clear button should not be visible initially")
    }

    func testSearchInput() throws {
        let searchField = app.textFields["SearchByName_TextField"]

        // Enter search text
        searchField.tap()
        searchField.typeText("Pikachu")

        // Verify clear button appears
        let clearButton = app.buttons["Close_AppIcon_Image"]
        XCTAssertTrue(clearButton.exists, "Clear button should appear when text is entered")

        // Clear text
        clearButton.tap()
        XCTAssertEqual(searchField.value as? String, "Search By Name", "Search field should have `Search By Name` text after clearing")
        XCTAssertFalse(clearButton.exists, "Clear button should disappear after clearing")
    }

    func testSearchModeToggle() throws {
        // Tap search mode button
        let searchModeImage = app.images["SortingOptionsByNameOrType_AppIcon_Image"]
        searchModeImage.tap()

        // Verify mode options appear
        let nameOption = app.buttons["Search By Name"]
        let typeOption = app.buttons["Search By Type"]
        XCTAssertTrue(nameOption.exists, "Name search option should exist")
        XCTAssertTrue(typeOption.exists, "Type search option should exist")

        // Switch to type search
        typeOption.tap()
        let searchField = app.textFields["SearchByType_TextField"]
        XCTAssertTrue(searchField.exists, "Search field should update placeholder for type search")
    }

    func testSortingControls() throws {
        // Tap sort button
        let sortButton = app.buttons["SortingOptions_AppIcon_Image"]
        sortButton.tap()

        // Verify sort controls appear
        XCTAssertTrue(app.staticTexts["SortOptions_AppText_Text"].exists, "Sort options title should appear")

        // Add a sort criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Verify sort badge appears
        XCTAssertTrue(app.staticTexts["1_AppText_Text"].exists, "Sort badge should show count of 1")

        // Clear sorting
        let closeButtons = app.buttons.matching(identifier: "Close_AppIcon_Image")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()
        XCTAssertFalse(app.staticTexts["1_AppText_Text"].exists, "Sort badge should disappear after clearing")
    }
}
