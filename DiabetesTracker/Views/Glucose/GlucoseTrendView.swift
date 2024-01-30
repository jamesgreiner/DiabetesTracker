//
//  GlucoseTrendView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 1/17/24.
//

import Charts
import SwiftData
import SwiftUI

struct GlucoseTrendView: View {
    @Query(sort: [SortDescriptor(\GlucoseReading.date)]) private var glucoseReadings: [GlucoseReading]

    @State private var showRangeColors = false
    
    private let lowThreshold: Int = 80
    private let highThreshold: Int = 180
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                chart
                    .frame(height: geometry.size.height * 0.5)
                rangeColorsToggle
            }
        }
    }
}

extension GlucoseTrendView {
    // MARK: Views
    private var chart: some View {
        Chart(glucoseReadings) {
            PointMark(
                x: .value("Date", $0.date),
                y: .value("Glucose", $0.glucose)
            )
            .foregroundStyle(showRangeColors ? getPointColor(for: $0.glucose) : Color.theme.accent)
        }
        .padding()
    }
    
    private var rangeColorsToggle: some View {
        Toggle(isOn: $showRangeColors) {
            Text("Glucose Range Colors")
        }
            .padding()
    }
    
    // MARK: Functions
    private func getPointColor(for glucose: Int) -> Color {
        if glucose <= lowThreshold {
            return Color.theme.red
        }
        else if glucose >= highThreshold {
            return Color.theme.yellow
        }
        
        return Color.theme.green
    }
}

#Preview {
    GlucoseTrendView()
}
