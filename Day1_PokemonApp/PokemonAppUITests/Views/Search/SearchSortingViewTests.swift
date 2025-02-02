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

        app.buttons["arrow.up.arrow.down"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        // Verify header elements
        XCTAssertTrue(app.staticTexts["Sort Options"].exists, "Sort options title should exist")
        XCTAssertTrue(app.images["plus.circle"].exists, "Add criteria button should exist")

        // Verify empty state message
        XCTAssertTrue(app.staticTexts["No sort criteria selected"].exists, "Empty state message should be visible")
    }

    func testAddingSortCriteria() throws {
        // Add name sort
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()

        // Verify sort row appears
        XCTAssertTrue(app.staticTexts["Name"].exists, "Name sort criteria should appear")
        XCTAssertTrue(app.buttons["arrow.up"].exists, "Ascending direction button should exist")
        XCTAssertTrue(app.buttons["xmark.circle.fill"].exists, "Remove button should exist")

        // Verify empty state message is hidden
        XCTAssertFalse(app.staticTexts["No sort criteria selected"].exists, "Empty state should be hidden")
    }

    func testTogglingSortDirection() throws {
        // Add sort criteria
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()

        // Toggle direction
        let directionButton = app.buttons["arrow.up"]
        directionButton.tap()

        // Verify direction changed
        XCTAssertTrue(app.buttons["arrow.down"].exists, "Direction should change to descending")
    }

    func testRemovingSortCriteria() throws {
        // Add sort criteria
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()

        // Remove criteria
        let closeButtons = app.buttons.matching(identifier: "xmark.circle.fill")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()

        // Verify empty state returns
        XCTAssertTrue(app.staticTexts["No sort criteria selected"].exists, "Empty state should return")
    }
}
