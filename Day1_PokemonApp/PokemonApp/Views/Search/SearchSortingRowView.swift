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
                AppIcon(
                    imageName: "line.3.horizontal",
                    accessibilityID: "Horizontal Line"
                )
            }

            AppText(criteria.option.rawValue, style: .body)

            Spacer()

            Button(action: onDirectionToggle) {
                AppIcon(
                    imageName: criteria.ascending ? "arrow.up" : "arrow.down",
                    accessibilityID: criteria.ascending ? "Arrow Up" : "Arrow Down"
                )
            }

            Button(action: onRemove) {
                AppIcon(
                    imageName: "xmark.circle.fill",
                    accessibilityID: "Close"
                )
            }
        }
        .padding(AppStyle.Padding.xSmall)
        .background(AppStyle.BackgroundColors.secondary)
        .cornerRadius(AppStyle.Radius.corner)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: AppStyle.StackSpacing.xSmall) {
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
