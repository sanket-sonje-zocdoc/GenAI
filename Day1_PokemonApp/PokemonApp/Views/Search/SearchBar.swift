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

    /// The current sort criteria that determines how Pokemon will be sorted
    @Binding var sortCriteria: [SortCriteria]

    /// Whether the sort order is ascending
    @Binding var sortAscending: Bool

    // Add this new state property
    @State private var showSortControls = false

    // MARK: - Body

    var body: some View {
        VStack(spacing: AppStyle.StackSpacing.xSmall) {
            SearchInputView(
                text: $text,
                searchMode: $searchMode,
                showSortControls: $showSortControls,
                sortCriteria: $sortCriteria
            )

            if showSortControls {
                SearchSortingView(sortCriteria: $sortCriteria)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var searchText = ""
    @Previewable @State var searchMode = SearchMode.name
    @Previewable @State var sortCriteria = [SortCriteria(option: .name, ascending: true)]
    @Previewable @State var sortAscending = true

    VStack {
        SearchBar(
            text: .constant(""),
            searchMode: .constant(.name),
            sortCriteria: .constant([SortCriteria(option: .name, ascending: true)]),
            sortAscending: .constant(true)
        )
        .padding()

        SearchBar(
            text: .constant("Pikachu"),
            searchMode: .constant(.name),
            sortCriteria: .constant([SortCriteria(option: .attack, ascending: false)]),
            sortAscending: .constant(false)
        )
        .padding()
    }
    .preferredColorScheme(.light)
}
