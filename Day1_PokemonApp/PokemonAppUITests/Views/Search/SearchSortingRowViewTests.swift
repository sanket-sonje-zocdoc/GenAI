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
        app.buttons["arrow.up.arrow.down"].tap()
        app.images["plus.circle"].tap()
        app.buttons["Name"].tap()
    }

    // MARK: - Tests

    func testRowComponents() throws {
        XCTAssertTrue(app.staticTexts["Name"].exists, "Criteria name should be visible")
        XCTAssertTrue(app.buttons["arrow.up"].exists, "Direction button should exist")
        XCTAssertTrue(app.buttons["xmark.circle.fill"].exists, "Remove button should exist")
    }

    func testDirectionToggle() throws {
        // Initial state is ascending
        XCTAssertTrue(app.buttons["arrow.up"].exists, "Initial direction should be ascending")

        // Toggle direction
        app.buttons["arrow.up"].tap()
        XCTAssertTrue(app.buttons["arrow.down"].exists, "Direction should change to descending")

        // Toggle back
        app.buttons["arrow.down"].tap()
        XCTAssertTrue(app.buttons["arrow.up"].exists, "Direction should change back to ascending")
    }

    func testReorderHandleVisibility() throws {
        // Single criteria - no reorder handle
        XCTAssertEqual(app.images.matching(identifier: "line.3.horizontal").count, 0, "Reorder handle should not exist for single criteria")

        // Add second criteria
        app.images["plus.circle"].tap()
        app.buttons["HP"].tap()

        // Verify reorder handles appear
        XCTAssertEqual(app.images.matching(identifier: "line.3.horizontal").count, 2, "Reorder handles should appear for multiple criteria")
    }
}
