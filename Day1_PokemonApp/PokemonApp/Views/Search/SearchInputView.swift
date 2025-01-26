//
//  SearchInputView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import PokemonUI
import SwiftUI

/// A reusable search input view component that provides the main search interface.
///
/// The SearchInputView contains:
/// - A magnifying glass icon
/// - A search text field
/// - A search mode selector menu (name/type)
/// - A sort toggle button
/// - A clear button (when text is present)
struct SearchInputView: View {

    // MARK: - Properties

    /// The text binding that manages the search input value
    @Binding var text: String

    /// The current search mode (.name or .type)
    @Binding var searchMode: SearchMode

    /// Controls the visibility of sort controls
    @Binding var showSortControls: Bool

    @Binding var sortOption: SortOption
    @Binding var sortAscending: Bool

    // MARK: - Body

    var body: some View {
        AppCard {
            HStack {
                // Search Icon
                AppIcon(systemName: "magnifyingglass")
                    .padding(AppStyle.Padding.xxSmall)

                // Search Field
                TextField(searchMode.placeholder, text: $text)
                    .textFieldStyle(.plain)

                // Search by name / type Button
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

                // Sorting Button
                Button {
                    showSortControls.toggle()
                } label: {
                    AppIcon(systemName: "arrow.up.arrow.down")
                        .padding(.trailing, AppStyle.Padding.xxSmall)
                }

                // Clear Button
                if !text.isEmpty {
                    Button(
                        action: {
                            if !text.isEmpty {
                                text = ""
                            }

                            // Reset sorting to name ascending
                            sortOption = .name
                            sortAscending = true

                            // If the Sort Control View is visible, hide it
                            if showSortControls {
                                showSortControls.toggle()
                            }
                        }
                    ) {
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
    VStack {
        SearchInputView(
            text: .constant(""),
            searchMode: .constant(.name),
            showSortControls: .constant(false),
            sortOption: .constant(.name),
            sortAscending: .constant(true)
        )

        SearchInputView(
            text: .constant("Pikachu"),
            searchMode: .constant(.type),
            showSortControls: .constant(true),
            sortOption: .constant(.name),
            sortAscending: .constant(true)
        )
    }
    .padding()
}
