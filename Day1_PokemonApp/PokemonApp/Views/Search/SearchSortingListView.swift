//
//  SearchSortingListView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 26/01/25.
//

import PokemonUI
import SwiftUI

/// A view that displays and manages a list of active sort criteria.
///
/// This view provides:
/// - A placeholder message when no criteria are selected
/// - A list of sort criteria rows with:
///   - Toggle direction functionality
///   - Remove criteria functionality
///   - Reorder handles when multiple criteria exist
///
/// Usage:
/// ```
/// SearchSortingListView(sortCriteria: $viewModel.sortCriteria)
/// ```
struct SearchSortingListView: View {

    // MARK: - Properties

    @Binding var sortCriteria: [SortCriteria]

    // MARK: - Body

    var body: some View {
        if sortCriteria.isEmpty {
            Text("No sort criteria selected")
                .foregroundColor(.secondary)
                .padding(.vertical, AppStyle.Padding.xSmall)
        } else {
            ForEach(Array(sortCriteria.enumerated()), id: \.offset) { index, criteria in
                SearchSortingRowView(
                    criteria: criteria,
                    showReorderHandle: sortCriteria.count > 1,
                    onDirectionToggle: { toggleSortDirection(at: index) },
                    onRemove: { removeSortCriteria(at: index) }
                )
            }
        }
    }

    // MARK: - Private Helpers

    private func removeSortCriteria(at index: Int) {
        sortCriteria.remove(at: index)
    }

    private func toggleSortDirection(at index: Int) {
        let criteria = sortCriteria[index]
        sortCriteria[index] = SortCriteria(
            option: criteria.option,
            ascending: !criteria.ascending
        )
    }
}

// MARK: - Preview

#Preview {
    VStack {
        // Empty state
        SearchSortingListView(sortCriteria: .constant([]))

        // With sort criteria
        SearchSortingListView(
            sortCriteria: .constant([
                SortCriteria(option: .name, ascending: true),
                SortCriteria(option: .type, ascending: false),
                SortCriteria(option: .hp, ascending: true)
            ])
        )
    }
    .padding()
}
