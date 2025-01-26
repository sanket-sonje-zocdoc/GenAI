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

    /// The current sort option that determines how Pokemon will be sorted
    @Binding var sortOption: SortOption

    /// Whether the sort order is ascending
    @Binding var sortAscending: Bool

    // Add this new state property
    @State private var showSortControls = false

    // MARK: - Body

    var body: some View {
        VStack(spacing: AppStyle.Padding.xSmall) {
            SearchInputView(
                text: $text,
                searchMode: $searchMode,
                showSortControls: $showSortControls,
                sortOption: $sortOption,
                sortAscending: $sortAscending
            )

            if showSortControls {
                SearchSortingView(sortOption: $sortOption, sortAscending: $sortAscending)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var searchText = ""
    @Previewable @State var searchMode = SearchMode.name
    @Previewable @State var sortOption = SortOption.name
    @Previewable @State var sortAscending = true

    VStack {
        SearchBar(
            text: .constant(""),
            searchMode: .constant(.name),
            sortOption: .constant(.name),
            sortAscending: .constant(true)
        )
        .padding()

        SearchBar(
            text: .constant("Pikachu"),
            searchMode: .constant(.name),
            sortOption: .constant(.attack),
            sortAscending: .constant(false)
        )
        .padding()
    }
    .preferredColorScheme(.light)
}
