//
//  SearchBar.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import PokemonUI
import SwiftUI

/// A reusable search bar component that provides a search interface with multiple search modes.
///
/// The SearchBar view creates a search input field with:
/// - A magnifying glass icon
/// - A search mode selector menu (name/type)
/// - A clear button that appears when text is entered
///
/// Example usage:
/// ```
/// @State private var searchText = ""
/// @State private var searchMode = SearchMode.name
///
/// SearchBar(text: $searchText, searchMode: $searchMode)
/// ```
///
/// - Note: The search bar automatically handles the clear functionality when the X button is tapped.
struct SearchBar: View {

    // MARK: - Properties

    /// The text binding that manages the search input value.
    /// This binding allows two-way communication between the search bar and its parent view.
    @Binding var text: String

    /// The current search mode (.name or .type) that determines how the search will be performed.
    /// This binding allows the parent view to react to search mode changes.
    @Binding var searchMode: SearchMode

    // MARK: - Body

    var body: some View {
        AppCard {
            HStack {
                AppIcon(systemName: "magnifyingglass")
                    .padding(AppStyle.Padding.xxSmall)

                TextField(searchMode.placeholder, text: $text)
                    .textFieldStyle(.plain)

                Menu {
                    Button(action: { searchMode = .name }) {
                        Label("Search by Name", systemImage: SearchMode.name.icon)
                    }

                    Button(action: { searchMode = .type }) {
                        Label("Search by Type", systemImage: SearchMode.type.icon)
                    }
                } label: {
                    AppIcon(systemName: "line.3.horizontal.decrease.circle")
                        .padding(.trailing, AppStyle.Padding.xxSmall)
                }

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
    @Previewable @State var searchText = ""
    @Previewable @State var searchMode = SearchMode.name

    VStack {
        SearchBar(text: .constant(""), searchMode: .constant(.name))
            .padding()

        SearchBar(text: .constant("Pikachu"), searchMode: .constant(.name))
            .padding()
    }
    .preferredColorScheme(.light)
}
