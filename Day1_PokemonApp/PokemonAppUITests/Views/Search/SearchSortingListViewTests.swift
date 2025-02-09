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
        app.buttons["SortingOptions_AppIcon_Image"].tap()
    }

    // MARK: - Tests

    func testEmptyState() throws {
        XCTAssertTrue(app.staticTexts["NoSortCriteriaSelected_AppText_Text"].exists, "Empty state message should be visible")
    }

    func testMultipleCriteria() throws {
        // Add first criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Add second criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["HP"].tap()

        // Verify reorder handles appear
        let reorderHandles = app.images.matching(identifier: "HorizontalLine_AppIcon_Image")
        XCTAssertEqual(reorderHandles.count, 2, "Reorder handles should appear for multiple criteria")

        // Verify both criteria exist
        XCTAssertTrue(app.staticTexts["Name"].exists, "First criteria should exist")
        XCTAssertTrue(app.staticTexts["HP"].exists, "Second criteria should exist")
    }

    func testRemovingCriteria() throws {
        // Add criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()

        // Remove criteria
        let closeButtons = app.buttons.matching(identifier: "Close_AppIcon_Image")
        let sortingCloseButton = closeButtons.element(boundBy: 1)
        sortingCloseButton.tap()

        // Verify empty state returns
        XCTAssertTrue(app.staticTexts["NoSortCriteriaSelected_AppText_Text"].exists, "Empty state should return")
    }
}
