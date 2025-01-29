//
//  AppPicker.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 29/01/25.
//

import SwiftUI

/// A custom picker component that maintains consistent styling across the app
///
/// `AppPicker` provides a standardized menu-style picker that follows the app's design system.
/// It supports both optional and non-optional selection values and automatically applies
/// the app's styling guidelines.
///
/// Usage example:
/// ```
/// @State private var selection = "Option 1"
///
/// AppPicker("Select an option", selection: $selection) {
///     ForEach(options, id: \.self) { option in
///         AppText(option, style: .body).tag(option)
///     }
/// }
/// ```
///
/// Features:
/// - Consistent styling with the app's design system
/// - Support for optional and non-optional selections
/// - Menu-style presentation
/// - Customizable content through ViewBuilder
/// - Automatic shadow and corner radius application
public struct AppPicker<SelectionValue: Hashable, Content: View>: View {

    // MARK: - Properties

    /// The title displayed in the picker's menu button
    public let title: String

    /// The currently selected value, bound to the parent view
    @Binding public var selection: SelectionValue

    /// The content builder for the picker's options
    @ViewBuilder public let content: () -> Content

    // MARK: - Initialization

    /// Creates a new AppPicker instance
    /// - Parameters:
    ///   - title: The title to display in the picker's menu button
    ///   - selection: A binding to the selected value
    ///   - content: A view builder closure that creates the picker's options
    public init(
        _ title: String,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self._selection = selection
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        Picker(title, selection: $selection) {
            content()
        }
        .pickerStyle(.menu)
        .font(AppTextStyle.caption.font)
        .padding(AppStyle.Padding.xSmall)
        .background(AppStyle.Colors.systemBackground)
        .cornerRadius(8)
        .shadow(radius: AppStyle.Radius.shadow)
    }

    private var titleView: some View {
        AppText(title, style: .title)
    }
}

// MARK: - Previews

#Preview("AppPicker Examples") {
    struct PreviewContainer: View {
        @State private var stringSelection = "Pikachu"
        @State private var optionalSelection: String? = nil

        var body: some View {
            VStack(spacing: 20) {
                AppPicker(
                    "Select Pokemon",
                    selection: $stringSelection
                ) {
                    ForEach(["Pikachu", "Charizard", "Bulbasaur"], id: \.self) { pokemon in
                        AppText(pokemon, style: .body).tag(pokemon)
                    }
                }

                AppPicker(
                    "Select Move",
                    selection: $optionalSelection
                ) {
                    AppText("Select a move", style: .body).tag(nil as String?)
                    ForEach(["Thunder", "Fire Blast", "Solar Beam"], id: \.self) { move in
                        AppText(move, style: .body).tag(move as String?)
                    }
                }
            }
            .padding()
        }
    }

    return PreviewContainer()
}
