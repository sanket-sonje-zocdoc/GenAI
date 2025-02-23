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

    @Binding var sortCriteria: [SortCriteria]

    // MARK: - Body

    var body: some View {
        AppCard {
            HStack {
                // Search Icon
                AppIcon(systemName: "magnifyingglass", accessibilityID: "Magnifying Glass")
                    .padding(AppStyle.Padding.xxSmall)

                // Search Field
                TextField(searchMode.placeholder, text: $text)
                    .textFieldStyle(.plain)
                    .a11yID(searchMode.placeholder, view: .notPresent, component: .textField)

                // Search by name / type Button
                Menu {
                    Button(action: { searchMode = .name }) {
                        AppLabel(
                            "Search By Name",
                            systemImage: SearchMode.name.icon
                        )
                    }

                    Button(action: { searchMode = .type }) {
                        AppLabel(
                            "Search By Type",
                            systemImage: SearchMode.type.icon
                        )
                    }
                } label: {
                    AppIcon(
                        systemName: "line.3.horizontal.decrease.circle",
                        accessibilityID: "Sorting Options By Name Or Type"
                    )
                        .padding(.trailing, AppStyle.Padding.xxSmall)
                }

                // Sorting Button with Badge
                Button {
                    showSortControls.toggle()
                } label: {
                    AppIcon(
                        systemName: "arrow.up.arrow.down",
                        accessibilityID: "Sorting Options"
                    )
                        .padding(.trailing, AppStyle.Padding.xxSmall)
                        .overlay(alignment: .topTrailing) {
                            if !sortCriteria.isEmpty {
                                AppText(
                                    "\(sortCriteria.count)",
                                    style: .customRegular(
                                        fontSize: AppStyle.FontSize.normal,
                                        color: AppStyle.BackgroundColors.primary
                                    )
                                )
                                .padding(4)
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .offset(x: 7.5, y: -10)
                            }
                        }
                }

                // Clear Button
                if !text.isEmpty || !sortCriteria.isEmpty {
                    Button(
                        action: {
                            // Clear search text
                            text = ""
                            
                            // Clear all sort criteria
                            sortCriteria.removeAll()

                            // If the Sort Control View is visible, hide it
                            if showSortControls {
                                showSortControls.toggle()
                            }
                        }
                    ) {
                        AppIcon(
                            systemName: "xmark.circle.fill",
                            accessibilityID: "Close"
                        )
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
            sortCriteria: .constant([])
        )

        SearchInputView(
            text: .constant("Pikachu"),
            searchMode: .constant(.type),
            showSortControls: .constant(true),
            sortCriteria: .constant([
                SortCriteria(option: .name, ascending: true),
                SortCriteria(option: .type, ascending: true)
            ])
        )
    }
    .padding()
}
