//
//  ContentView.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import SwiftUI

/// A view that displays a list of Pokemon and provides navigation to RGB color analysis.
///
/// This view serves as the main screen of the application with two main components:
/// 1. A list showing all Pokemon names that start with 'A'
/// 2. A button that navigates to a chart view showing RGB color analysis of Pokemon sprites
///
/// The view handles different states:
/// - Loading state: Shows a progress indicator while fetching data
/// - Error state: Displays an alert with error details if data fetching fails
/// - Success state: Shows the Pokemon list and analysis button
///
/// The view uses a `PokemonStatsViewModel` to manage:
/// - Fetching Pokemon data
/// - Maintaining the list of Pokemon
/// - Managing chart data
/// - Handling error states
struct ContentView: View {

    // MARK: - Properties

    @StateObject private var viewModel: PokemonStatsViewModel
    @State private var showChart = false

    // MARK: - Initialization

    init(session: URLSession) {
        _viewModel = StateObject(wrappedValue: PokemonStatsViewModel(session: session))
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.pokemonList.isEmpty {
                    ProgressView()
                } else {
                    List(viewModel.pokemonList, id: \.name) { pokemon in
                        Text(pokemon.name.capitalized)
                    }
                }

                if !viewModel.chartData.isEmpty {
                    NavigationLink(destination: chartView, isActive: $showChart) {
                        Button(action: { showChart = true }) {
                            HStack {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                Text("View RGB Analysis")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Pokemon List")
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

    // MARK: - Supporting Views

    private var chartView: some View {
        RGBChartView(data: viewModel.chartData)
            .navigationTitle("RGB Analysis")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(session: URLSession.shared)
    }
}
