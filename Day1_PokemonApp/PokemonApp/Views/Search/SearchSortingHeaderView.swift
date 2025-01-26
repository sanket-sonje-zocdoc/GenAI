//
//  SearchSortingHeaderView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 26/01/25.
//

import PokemonUI
import SwiftUI

/// A view that displays the header section of the sorting interface.
///
/// This view provides:
/// - A title indicating the sorting section
/// - A menu button to add new sort criteria
/// - Automatic disabling of the add button when maximum criteria (3) is reached
///
/// Usage:
/// ```
/// SearchSortingHeaderView(sortCriteria: $viewModel.sortCriteria)
/// ```
struct SearchSortingHeaderView: View {

    // MARK: - Properties

    @Binding var sortCriteria: [SortCriteria]

    // MARK: - Body

    var body: some View {
        HStack {
            Text("Sort Options")
                .font(.headline)
            Spacer()

            Menu {
                ForEach(SortOption.allCases, id: \.self) { option in
                    if !sortCriteria.contains(where: { $0.option == option }) {
                        Button {
                            addSortCriteria(option: option)
                        } label: {
                            Label(option.rawValue, systemImage: "plus")
                        }
                    }
                }
            } label: {
                AppIcon(systemName: "plus.circle")
            }
            .disabled(sortCriteria.count >= 3)
        }
    }

    // MARK: - Private Helpers

    private func addSortCriteria(option: SortOption) {
        sortCriteria.append(SortCriteria(option: option, ascending: true))
    }
}

// MARK: - Preview

#Preview {
    VStack {
        SearchSortingHeaderView(sortCriteria: .constant([]))

        SearchSortingHeaderView(
            sortCriteria: .constant([
                SortCriteria(option: .name, ascending: true),
                SortCriteria(option: .type, ascending: false),
                SortCriteria(option: .hp, ascending: true)
            ])
        )
    }
    .padding()
}
