//
//  SearchSortingListViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class SearchSortingListViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        app.buttons["arrow.up.arrow.down"].tap()
    }

    // MARK: - Tests

    func testEmptyState() throws {
        XCTAssertTrue(app.staticTexts["No sort criteria selected"].exists, "Empty state message should be visible")
    }

    func testMultipleCriteria() throws {
        // Add first criteria
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()

        // Add second criteria
        app.images["plus.circle"].tap()
        app.buttons["HP"].tap()

        // Verify reorder handles appear
        let reorderHandles = app.images.matching(identifier: "line.3.horizontal")
        XCTAssertEqual(reorderHandles.count, 2, "Reorder handles should appear for multiple criteria")

        // Verify both criteria exist
        XCTAssertTrue(app.staticTexts["Name"].exists, "First criteria should exist")
        XCTAssertTrue(app.staticTexts["HP"].exists, "Second criteria should exist")
    }

    func testRemovingCriteria() throws {
        // Add criteria
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
