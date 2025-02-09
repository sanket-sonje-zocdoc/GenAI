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

    /// The array of sort criteria that determines how Pokemon will be sorted
    @Binding var sortCriteria: [SortCriteria]

    // MARK: - Body

    var body: some View {
        AppCard {
            VStack(spacing: AppStyle.StackSpacing.xSmall) {
                SearchSortingHeaderView(
                    sortCriteria: $sortCriteria
                )
                
                SearchSortingListView(
                    sortCriteria: $sortCriteria
                )
            }
            .padding(AppStyle.Padding.xSmall)
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        SearchSortingView(
            sortCriteria: .constant([])
        )
        
        SearchSortingView(
            sortCriteria: .constant([
                SortCriteria(option: .name, ascending: true),
                SortCriteria(option: .type, ascending: false),
                SortCriteria(option: .hp, ascending: true)
            ])
        )
    }
    .padding()
}
