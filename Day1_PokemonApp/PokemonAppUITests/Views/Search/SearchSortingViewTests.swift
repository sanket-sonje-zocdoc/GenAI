//
//  SearchSortingViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class SearchSortingViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        app.buttons["SortingOptions_AppIcon_Image"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        // Verify header elements
        XCTAssertTrue(app.staticTexts["SortOptions_AppText_Text"].exists, "Sort options title should exist")
        XCTAssertTrue(app.images["AddSortingOption_AppIcon_Image"].exists, "Add criteria button should exist")

        // Verify empty state message
        XCTAssertTrue(app.staticTexts["No sort criteria selected"].exists, "Empty state message should be visible")
    }

    func testAddingSortCriteria() throws {
        // Add name sort
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Verify sort row appears
        XCTAssertTrue(app.staticTexts["Name"].exists, "Name sort criteria should appear")
        XCTAssertTrue(app.buttons["ArrowUp_AppIcon_Image"].exists, "Ascending direction button should exist")
        XCTAssertTrue(app.buttons["Close_AppIcon_Image"].exists, "Remove button should exist")

        // Verify empty state message is hidden
        XCTAssertFalse(app.staticTexts["NoSortCriteriaSelected_AppText_Text"].exists, "Empty state should be hidden")
    }

    func testTogglingSortDirection() throws {
        // Add sort criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Toggle direction
        let directionButton = app.buttons["ArrowUp_AppIcon_Image"]
        directionButton.tap()

        // Verify direction changed
        XCTAssertTrue(app.buttons["ArrowDown_AppIcon_Image"].exists, "Direction should change to descending")
    }

    func testRemovingSortCriteria() throws {
        // Add sort criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Remove criteria
        let closeButtons = app.buttons.matching(identifier: "Close_AppIcon_Image")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()

        // Verify empty state returns
        XCTAssertTrue(app.staticTexts["No sort criteria selected"].exists, "Empty state should return")
    }
}
