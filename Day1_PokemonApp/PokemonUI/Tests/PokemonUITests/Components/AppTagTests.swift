import XCTest
import SwiftUI
@testable import PokemonUI

@MainActor
final class AppTagTests: XCTestCase {

    // MARK: - Tests
    
    func testInitialization() {
        let text = "Test Tag"
        let color = Color.red
        let tag = AppTag(text: text, color: color)
        
        XCTAssertEqual(tag.text, text)
        XCTAssertEqual(tag.color, color)
    }
} 
