//
//  RGBChartView.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Charts
import SwiftUI

/// A view that presents a line chart visualization of cumulative RGB color sums for Pokemon sprites.
///
/// This view creates an interactive chart that shows:
/// - A line graph of cumulative RGB color sums across Pokemon sprites
/// - Individual data points for each Pokemon
/// - Rotated X-axis labels for better readability
/// - Clearly labeled axes with proper scaling
///
/// Example usage:
/// ```
/// RGBChartView(data: pokemonRGBData)
/// ```
struct RGBChartView: View {

    // MARK: - Properties

    /// The collection of RGB data points to be displayed in the chart
    let data: [RGBChartData]

    /// Calculates the total sum of all RGB values
    /// - Returns: The final cumulative sum from the last data point, or 0 if the data is empty
    private var totalSum: Int {
        data.last?.cumulativeSum ?? 0
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Cumulative Color Sum of Pokemon Sprites")
                .font(.headline)
                .padding(.horizontal)
            
            Text("Total Cumulative Sum: \(totalSum)")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                Chart(data) { item in
                    LineMark(
                        x: .value("Pokemon", item.pokemonName),
                        y: .value("RGB Sum", item.cumulativeSum)
                    )
                    .foregroundStyle(.blue.gradient)
                    
                    PointMark(
                        x: .value("Pokemon", item.pokemonName),
                        y: .value("RGB Sum", item.cumulativeSum)
                    )
                    .foregroundStyle(.blue)
                }
                .chartXAxis {
                    AxisMarks { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(centered: true) {
                            Text(value.as(String.self) ?? "")
                                .rotationEffect(Angle(degrees: -45))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(centered: true)
                    }
                }
                .chartXAxisLabel("Pokemon Count", alignment: .center)
                .chartYAxisLabel("Color Sum", position: .leading, alignment: .center)
                .frame(width: CGFloat(data.count * 60), height: 500)
                .padding()
            }
        }
    }
}
