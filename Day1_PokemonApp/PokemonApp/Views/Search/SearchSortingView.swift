//
//  SearchSortingView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import PokemonUI
import SwiftUI

/// A reusable sorting view component that provides sorting controls.
///
/// The SearchSortingView allows users to:
/// - Select a sorting criteria from available options
/// - Toggle between ascending and descending order
struct SearchSortingView: View {

    // MARK: - Properties

    /// The current sort option that determines how Pokemon will be sorted
    @Binding var sortOption: SortOption

    /// Whether the sort order is ascending
    @Binding var sortAscending: Bool

    // MARK: - Body

    var body: some View {
        AppCard {
            HStack {
                // Sorting Icon
                AppIcon(systemName: "arrow.up.arrow.down")
                    .padding(AppStyle.Padding.xxSmall)

                // Sorting Menu
                Menu {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            sortOption = option
                        }
                    }
                } label: {
                    HStack {
                        Text("Sort by: \(sortOption.rawValue)")
                            .foregroundColor(.primary)
                        Spacer()
                        AppIcon(systemName: "chevron.down")
                    }
                }

                // Arrow Icon Button
                Button {
                    sortAscending.toggle()
                } label: {
                    AppIcon(systemName: sortAscending ? "arrow.up" : "arrow.down")
                }
                .padding(.trailing, AppStyle.Padding.xSmall)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        SearchSortingView(
            sortOption: .constant(.name),
            sortAscending: .constant(true)
        )
        SearchSortingView(
            sortOption: .constant(.attack),
            sortAscending: .constant(false)
        )
    }
    .padding()
}
