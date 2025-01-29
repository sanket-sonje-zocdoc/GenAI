//
//  AppPickerTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppPickerTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    func testAppPickerInitialization() {
        // Given
        let title = "Test Picker"
        @State var selection = "Option 1"
        
        // When
        let picker = AppPicker(
            title,
            selection: $selection
        ) {
            Text("Option 1").tag("Option 1")
            Text("Option 2").tag("Option 2")
        }
        
        // Then
        XCTAssertEqual(picker.title, title)
    }
    
    func testAppPickerBody() throws {
        // Given
        let title = "Test Picker"
        @State var selection = "Option 1"
        
        // When
        let picker = AppPicker(
            title,
            selection: $selection
        ) {
            Text("Option 1").tag("Option 1")
            Text("Option 2").tag("Option 2")
        }
        
        // Then
        let pickerView = picker.body
        XCTAssertNotNil(pickerView)
        
        let mirror = Mirror(reflecting: pickerView)
        let font = try XCTUnwrap(findView(in: mirror) as Font?)
        XCTAssertEqual(font, AppTextStyle.caption.font)
    }
    
    func testAppPickerWithOptionalSelection() {
        // Given
        let title = "Test Picker"
        @State var selection: String? = nil
        
        // When
        let picker = AppPicker(
            title,
            selection: $selection
        ) {
            Text("None").tag(nil as String?)
            Text("Option 1").tag("Option 1" as String?)
        }
        
        // Then
        XCTAssertEqual(picker.title, title)
        XCTAssertNotNil(picker.body)
    }
}
