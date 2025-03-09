//
//  MainTabView.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import SwiftUI
import PokemonUI

/// The main tab view container for the Pokemon app.
/// This view manages navigation between different main sections of the app:
/// - Pokemon List (Home)
/// - Compare Pokemon
/// - Settings (Future)
struct TabBarView: View {

    // MARK: - Properties

    @StateObject private var viewModel: PokemonViewModel

    // MARK: - Initialization

    init(session: URLSession) {
        _viewModel = StateObject(
            wrappedValue: PokemonViewModel(
                pokemonService: PokemonServiceAPIImpl(session: session)
            )
        )
    }

    // MARK: - Body

    var body: some View {
        TabView {
            ContentView(viewModel: viewModel)
                .tabItem {
                    AppLabel(
                        "Pokemon",
                        style: .caption,
                        systemImage: "list.bullet"
                    )
                }

            PokemonCompareView(viewModel: viewModel)
                .tabItem {
                    AppLabel(
                        "Compare",
                        style: .caption,
                        systemImage: "arrow.left.arrow.right"
                    )
                }
        }
        .tint(.blue)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Preview

#Preview {
    TabBarView(session: URLSession.shared)
}
