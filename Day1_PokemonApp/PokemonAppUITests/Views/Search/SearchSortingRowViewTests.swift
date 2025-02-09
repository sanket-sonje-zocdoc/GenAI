//
//  SearchSortingRowViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class SearchSortingRowViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        app.buttons["SortingOptions_AppIcon_Image"].tap()
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["Name"].tap()
    }

    // MARK: - Tests

    func testRowComponents() throws {
        XCTAssertTrue(app.staticTexts["Name"].exists, "Criteria name should be visible")
        XCTAssertTrue(app.buttons["ArrowUp_AppIcon_Image"].exists, "Direction button should exist")
        XCTAssertTrue(app.buttons["Close_AppIcon_Image"].exists, "Remove button should exist")
    }

    func testDirectionToggle() throws {
        // Initial state is ascending
        XCTAssertTrue(app.buttons["ArrowUp_AppIcon_Image"].exists, "Initial direction should be ascending")

        // Toggle direction
        app.buttons["ArrowUp_AppIcon_Image"].tap()
        XCTAssertTrue(app.buttons["ArrowDown_AppIcon_Image"].exists, "Direction should change to descending")

        // Toggle back
        app.buttons["ArrowDown_AppIcon_Image"].tap()
        XCTAssertTrue(app.buttons["ArrowUp_AppIcon_Image"].exists, "Direction should change back to ascending")
    }

    func testReorderHandleVisibility() throws {
        // Single criteria - no reorder handle
        XCTAssertEqual(app.images.matching(identifier: "HorizontalLine_AppIcon_Image").count, 0, "Reorder handle should not exist for single criteria")

        // Add second criteria
        app.images["AddSortingOption_AppIcon_Image"].tap()
        app.buttons["HP"].tap()

        // Verify reorder handles appear
        XCTAssertEqual(app.images.matching(identifier: "HorizontalLine_AppIcon_Image").count, 2, "Reorder handles should appear for multiple criteria")
    }
}
