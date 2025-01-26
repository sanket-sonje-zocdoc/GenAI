import XCTest
import SwiftUI
@testable import PokemonUI

@MainActor
final class AppCardTests: XCTestCase {

    // MARK: - Tests

    func testDefaultPadding() {
        let card = AppCard {
            Text("Test")
        }
        
        XCTAssertEqual(card.padding.top, AppStyle.Padding.xSmall)
        XCTAssertEqual(card.padding.leading, AppStyle.Padding.normal)
        XCTAssertEqual(card.padding.bottom, AppStyle.Padding.xSmall)
        XCTAssertEqual(card.padding.trailing, AppStyle.Padding.normal)
    }
    
    func testContentInitialization() {
        let testText = "Test Content"
        let card = AppCard {
            Text(testText)
        }
        
        // Verify content is initialized
        let mirror = Mirror(reflecting: card)
        let contentProperty = mirror.children.first { $0.label == "content" }
        XCTAssertNotNil(contentProperty)
    }
} 
