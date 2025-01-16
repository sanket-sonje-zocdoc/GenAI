//
//  ContentView.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import SwiftUI

/// A view that displays Pokemon RGB color analysis data in a chart format.
///
/// This view serves as the main screen of the application, showing a chart that visualizes
/// RGB color distribution across Pokemon sprites. It handles both the loading state and error
/// presentations.
///
/// The view uses a `PokemonStatsViewModel` to manage data fetching and state management.
struct ContentView: View {

    // MARK: - Properties

    @StateObject private var viewModel: PokemonStatsViewModel

    // MARK: - Properties

    init(session: URLSession) {
        _viewModel = StateObject(wrappedValue: PokemonStatsViewModel(session: session))
    }

    // MARK: - Inits

    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.chartData.isEmpty {
                    RGBChartView(data: viewModel.chartData)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Pokemon RGB Analysis")
        }
        .onAppear {
            viewModel.fetchPokemonList()
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK") {
                viewModel.error = nil
            }
        } message: {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        }
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(session: URLSession.shared)
    }
}
