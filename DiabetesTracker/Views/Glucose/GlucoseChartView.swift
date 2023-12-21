//
//  GlucoseChartView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 12/10/23.
//

import Charts
import SwiftData
import SwiftUI

struct GlucoseChartView: View {
    @Query(sort: [SortDescriptor(\GlucoseReading.date)]) private var glucoseReadings: [GlucoseReading]

    var body: some View {
        VStack {
            chart
                //.background(chartBackground)
                //.overlay(chartGlucoseLabels, alignment: .trailing)
        }
    }
}

extension GlucoseChartView {
    // MARK: View Components
    private var chartLine: some View {
        Rectangle()
            .frame(height: 1)
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text("\(getMinimumDate().formatted(date: .numeric, time: .omitted))")
            Spacer()
            Text("\(getMaximumDate().formatted(date: .numeric, time: .omitted))")
        }
        .foregroundStyle(.gray)
        .padding(.horizontal, 5)
    }
    
    private var chartGlucoseLabels: some View {
        VStack {
            Text("0")
            Spacer()
            Text("200")
            Spacer()
            Text("400")
        }
        .foregroundStyle(.gray)
        
    }
    
    private var chartBackground: some View {
            VStack {
                VStack(spacing: 100) {
                    chartLine
                    chartLine
                    chartLine
                }
                chartDateLabels
            }
    }
    
    private var chart: some View {
        Chart {
            ForEach(glucoseReadings, id: \.self) { reading in
                LineMark(
                    x: .value("Date", reading.date),
                    y: .value("Glucose", reading.glucose)
                )
                .interpolationMethod(.catmullRom)
                
//                PointMark(
//                    x: .value("Date", reading.date),
//                    y: .value("Glucose", reading.glucose)
//                )
                    //.shadow(color: .blue, radius: 10, x: 0, y: 0)
            }
        }
        .chartYScale(domain: 20...300)
    }
    
    // MARK: Functions
    private func getMinimumDate() -> Date {
        return glucoseReadings.sorted(by: { $0.date < $1.date }).first?.date ?? Date()
    }
    
    private func getMaximumDate() -> Date {
        return glucoseReadings.sorted(by: { $0.date > $1.date }).first?.date ?? Date()
    }
    
    private func getGlucoseValues() -> [Int] {
        var res = [Int]()
        
        for reading in glucoseReadings {
            res.append(reading.glucose)
        }
        
        return res
    }
}

#Preview {
    GlucoseChartView()
}
