//
//  RGBChartData.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Represents a data point for the Pokemon RGB chart visualization
struct RGBChartData: Identifiable {

    /// Unique identifier for the chart data point
    let id = UUID()
    
    /// Name of the Pokemon this data point represents
    let pokemonName: String
    
    /// Running total of RGB sums up to this Pokemon
    let cumulativeSum: Int
}
