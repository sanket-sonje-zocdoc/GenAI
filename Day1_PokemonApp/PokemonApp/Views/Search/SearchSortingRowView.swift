//
//  SearchSortingRowView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 26/01/25.
//

import PokemonUI
import SwiftUI

/// A view that represents a single sort criteria row.
///
/// This view displays:
/// - An optional reorder handle (shown when multiple criteria exist)
/// - The sort option name
/// - A direction toggle button (ascending/descending)
/// - A remove button
///
/// Usage:
/// ```
/// SearchSortingRowView(
///     criteria: SortCriteria(option: .name, ascending: true),
///     showReorderHandle: true,
///     onDirectionToggle: { /* handle direction toggle */ },
///     onRemove: { /* handle removal */ }
/// )
/// ```
struct SearchSortingRowView: View {

    // MARK: - Properties

    let criteria: SortCriteria
    let showReorderHandle: Bool
    let onDirectionToggle: () -> Void
    let onRemove: () -> Void

    // MARK: - Body

    var body: some View {
        HStack {
            if showReorderHandle {
                AppIcon(systemName: "line.3.horizontal")
                    .foregroundColor(.secondary)
            }

            Text(criteria.option.rawValue)

            Spacer()

            Button(action: onDirectionToggle) {
                AppIcon(systemName: criteria.ascending ? "arrow.up" : "arrow.down")
            }

            Button(action: onRemove) {
                AppIcon(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(AppStyle.Padding.xSmall)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(AppStyle.Radius.corner)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: AppStyle.Padding.xSmall) {
        // Single criteria
        SearchSortingRowView(
            criteria: SortCriteria(option: .name, ascending: true),
            showReorderHandle: false,
            onDirectionToggle: {},
            onRemove: {}
        )

        // With reorder handle
        SearchSortingRowView(
            criteria: SortCriteria(option: .type, ascending: false),
            showReorderHandle: true,
            onDirectionToggle: {},
            onRemove: {}
        )

        // Different sort option
        SearchSortingRowView(
            criteria: SortCriteria(option: .hp, ascending: true),
            showReorderHandle: true,
            onDirectionToggle: {},
            onRemove: {}
        )
    }
    .padding()
}
