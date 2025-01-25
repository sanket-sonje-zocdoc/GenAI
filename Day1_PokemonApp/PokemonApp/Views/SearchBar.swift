//
//  SearchBar.swift
//  PokemonApp
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
        AppCard {
            HStack {
                AppIcon(systemName: "magnifyingglass")
                    .padding(AppStyle.Padding.xxSmall)

                TextField("Search Pokemon", text: $text)
                    .textFieldStyle(.plain)

                if !text.isEmpty {
                    Button(action: { text = "" }) {
                        AppIcon(systemName: "xmark.circle.fill")
                    }
                    .padding(.trailing, AppStyle.Padding.xSmall)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @State var searchText = ""

    return VStack {
        SearchBar(text: .constant(""))
            .padding()

        SearchBar(text: .constant("Pikachu"))
            .padding()
    }
    .preferredColorScheme(.light)
}
