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
            AppText("Sort Options", style: .headline)

            Spacer()

            Menu {
                ForEach(SortOption.Category.allCases, id: \.self) { category in
                    if let options = SortOption.groupedCases[category] {
                        Section(category == .basic ? "Basic" : "Stats") {
                            ForEach(options, id: \.self) { option in
                                if !sortCriteria.contains(where: { $0.option == option }) {
                                    Button {
                                        addSortCriteria(option: option)
                                    } label: {
                                        AppLabel(
                                            option.rawValue,
                                            image: "plus"
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            } label: {
                AppIcon(
                    systemName: "plus.circle",
                    size: AppStyle.FontSize.large,
                    accessibilityID: "Add Sorting Option"
                )
            }
        }
    }

    // MARK: - Private Helpers

    private func addSortCriteria(option: SortOption) {
        sortCriteria.append(SortCriteria(option: option, ascending: true))
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: AppStyle.StackSpacing.normal) {
        // Empty state
        VStack(alignment: .leading) {
            Text("Empty State")
                .font(.caption)
                .foregroundStyle(.secondary)
            SearchSortingHeaderView(sortCriteria: .constant([]))
        }

        // With basic attributes
        VStack(alignment: .leading) {
            Text("With Basic Attributes")
                .font(.caption)
                .foregroundStyle(.secondary)
            SearchSortingHeaderView(
                sortCriteria: .constant([
                    SortCriteria(option: .name, ascending: true),
                    SortCriteria(option: .type, ascending: false)
                ])
            )
        }

        // With mixed criteria
        VStack(alignment: .leading) {
            Text("With Mixed Criteria (Max)")
                .font(.caption)
                .foregroundStyle(.secondary)
            SearchSortingHeaderView(
                sortCriteria: .constant([
                    SortCriteria(option: .name, ascending: true),
                    SortCriteria(option: .hp, ascending: true),
                    SortCriteria(option: .attack, ascending: false)
                ])
            )
        }
    }
    .padding()
}
