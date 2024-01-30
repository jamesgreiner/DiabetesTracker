//
//  GlucoseRangeView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 1/17/24.
//

import Charts
import SwiftData
import SwiftUI

struct GlucoseRangeView: View {
    @Query private var glucoseReadings: [GlucoseReading]
    
    private let lowThreshold: Int = 80
    private let highThreshold: Int = 180
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                rangeChart
                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.5)
                legend
                    .padding(.horizontal, geometry.size.width * 0.15)
            }
        }
    }
}

extension GlucoseRangeView {
    // MARK: Views
    private var rangeChart: some View {
        Chart {
            // In Range Sector
            SectorMark(
                angle: .value("In Range", getNormalCount()),
                innerRadius: 0,
                angularInset: 1
            )
                .foregroundStyle(Color.theme.green)
            
            // Low Sector
            SectorMark(
                angle: .value("Low", getLowCount()),
                innerRadius: 0,
                angularInset: 1
            )
                .foregroundStyle(Color.theme.red)
            
            // High Sector
            SectorMark(
                angle: .value("High", getHighCount()),
                innerRadius: 0,
                angularInset: 1
            )
                .foregroundStyle(Color.theme.yellow)
        }
        .padding()
    }
    
    private var legend: some View {
        HStack {
            Spacer()
            VStack {
                HStack {
                    Rectangle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.theme.red)
                    Text("Low")
                        .frame(height: 25)
                    Spacer()
                    Text(formatAsPercent(getLowCount(), glucoseReadings.count))
                        .padding(.trailing)
                }
                HStack {
                    Rectangle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.theme.green)
                    Text("In Range")
                        .frame(height: 25)
                    Spacer()
                    Text(formatAsPercent(getNormalCount(), glucoseReadings.count))
                        .padding(.trailing)
                }
                HStack {
                    Rectangle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.theme.yellow)
                    Text("High")
                        .frame(height: 25)
                    Spacer()
                    Text(formatAsPercent(getHighCount(), glucoseReadings.count))
                        .padding(.trailing)
                }
            }
        }
        .padding()
        .background(Color.theme.background)
        .clipShape(.buttonBorder)
        .shadow(radius: 5)
    }
    
    // MARK: Functions
    private func getLowCount() -> Int {
        let lowCount = glucoseReadings.filter({ $0.glucose < lowThreshold }).count
        print("\(lowCount)")
        
        return lowCount
    }
    
    private func getNormalCount() -> Int {
        let normalCount = glucoseReadings.filter({ $0.glucose >= lowThreshold && $0.glucose <= highThreshold }).count
        print("\(normalCount)")
        
        return normalCount
    }
    
    private func getHighCount() -> Int {
        let highCount = glucoseReadings.filter({ $0.glucose > highThreshold }).count
        print("\(highCount)")
        
        return highCount
    }
    
    
    private func formatAsPercent(_ value: Int, _ total: Int) -> String {
        let fraction = Double(value) / Double(total)
        
        return fraction.formatted(.percent.precision(.fractionLength(2)))
    }
}

#Preview {
    GlucoseRangeView()
}
