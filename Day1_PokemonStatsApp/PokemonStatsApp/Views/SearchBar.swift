//
//  SearchBar.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

/// A reusable search bar component that provides a standard search interface.
///
/// The SearchBar view creates a search input field with a magnifying glass icon
/// and a clear button that appears when text is entered. It features a clean,
/// modern design with a white background and subtle shadow.
///
/// Example usage:
/// ```
/// @State private var searchText = ""
/// 
/// SearchBar(text: $searchText)
/// ```
///
/// - Note: The search bar automatically handles the clear functionality when the X button is tapped.
struct SearchBar: View {

    // MARK: - Properties

    /// The text binding that manages the search input value.
    /// This binding allows two-way communication between the search bar and its parent view.
    @Binding var text: String

    // MARK: - Body

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray.opacity(0.6))
                .font(.system(size: 16, weight: .medium))
                .padding(.leading, 8)

            TextField("Search Pokemon", text: $text)
                .textFieldStyle(.plain)
                .padding(.vertical, 12)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray.opacity(0.6))
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.trailing, 8)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
    }
}
