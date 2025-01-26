//
//  AppProgressBarTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppProgressBarTests: XCTestCase {

    // MARK: - Tests
    
    func testDefaultInitialization() {
        let progressBar = AppProgressBar(value: 50, maxValue: 100)

        // Test default values
        let mirror = Mirror(reflecting: progressBar)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })

        XCTAssertEqual(properties["value"] as? Double, 50)
        XCTAssertEqual(properties["maxValue"] as? Double, 100)
        XCTAssertEqual(properties["height"] as? CGFloat, 8)
        XCTAssertEqual(properties["cornerRadius"] as? CGFloat, 4)
    }

    func testCustomInitialization() {
        let progressBar = AppProgressBar(
            value: 75,
            maxValue: 100,
            height: 12,
            cornerRadius: 6
        )

        // Test custom values
        let mirror = Mirror(reflecting: progressBar)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })

        XCTAssertEqual(properties["value"] as? Double, 75)
        XCTAssertEqual(properties["maxValue"] as? Double, 100)
        XCTAssertEqual(properties["height"] as? CGFloat, 12)
        XCTAssertEqual(properties["cornerRadius"] as? CGFloat, 6)
    }

    func testValueClamping() {
        // Test value below 0
        let belowZero = AppProgressBar(value: -10, maxValue: 100)
        XCTAssertEqual(Mirror(reflecting: belowZero).children.first { $0.label == "value" }?.value as? Double, 0)

        // Test value above maxValue
        let aboveMax = AppProgressBar(value: 150, maxValue: 100)
        XCTAssertEqual(Mirror(reflecting: aboveMax).children.first { $0.label == "value" }?.value as? Double, 100)
    }

    func testForegroundColor() {
        // Test different percentage ranges and their corresponding colors
        let testCases: [(value: Double, maxValue: Double, expectedColor: Color)] = [
            (10, 100, .red),                                            // 0-20%
            (30, 100, Color(red: 1.0, green: 0.5, blue: 0.5)),          // 21-40%
            (50, 100, .yellow),                                         // 41-60%
            (70, 100, Color(red: 0.5, green: 0.8, blue: 0.5)),          // 61-80%
            (90, 100, .green)                                           // 81-100%
        ]

        for testCase in testCases {
            let progressBar = AppProgressBar(value: testCase.value, maxValue: testCase.maxValue)
            let foregroundColor = progressBar.foregroundColor
            XCTAssertEqual(foregroundColor, testCase.expectedColor, "Color mismatch for value: \(testCase.value)")
        }
    }
}
