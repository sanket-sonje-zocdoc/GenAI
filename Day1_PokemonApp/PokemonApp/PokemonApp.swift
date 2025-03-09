//
//  PokemonApp.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import PokemonUI
import SwiftUI

/// The main entry point for the Pokemon Stats application.
/// This file contains the app's root structure and configuration.
@main

/// The main application structure that conforms to the SwiftUI `App` protocol.
/// This serves as the entry point for the Pokemon Stats application.
struct PokemonApp: App {

    // MARK: - Properties

    /// The URLSession instance used for network requests throughout the app.
    /// This property enables dependency injection for network operations,
    /// making the app more testable by allowing mock sessions in tests.
    private let session: URLSession

    // MARK: - Inits

    init() {
        self.session = .shared
        AppFonts.register()
    }

    /// The body property required by the `App` protocol.
    /// Defines the root view hierarchy of the application.
    var body: some Scene {
        WindowGroup {
            TabBarView(session: session)
        }
    }
}
