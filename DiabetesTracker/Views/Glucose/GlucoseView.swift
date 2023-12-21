//
//  GlucoseView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 12/10/23.
//

import SwiftData
import SwiftUI

struct GlucoseView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var glucoseReadings: [GlucoseReading]
    
    @State private var displaySelection = "List"

    private let displayOptions = ["List", "Chart"]
    
    var body: some View {
        VStack {
            displaySelector
            
            Spacer()
            
            if displaySelection == "List" {
                GlucoseListView()
            }
            else if displaySelection == "Chart" {
                GlucoseChartView()
            }
        }
        .onAppear(perform: populateGlucoseData)
    }
}

extension GlucoseView {
    // MARK: View Components
    private var displaySelector: some View {
        Picker("", selection: $displaySelection) {
            ForEach(displayOptions, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    // MARK: Functions
    private func randomDate() -> Date {
        //let startDate = Date(timeIntervalSinceReferenceDate: TimeInterval(694_225_000)) // January 1, 2023
        let startDate = Date(timeIntervalSinceReferenceDate: TimeInterval(715_225_000)) // January 1, 2023
        let endDate = Date()
        let randomInterval = TimeInterval.random(in: startDate.timeIntervalSince1970...endDate.timeIntervalSince1970)
        return Date(timeIntervalSince1970: randomInterval)
    }
    
    private func populateGlucoseData() {
        if glucoseReadings.count < 50 {
            for _ in 0..<50 {
                let glucoseValue = Int.random(in: 80...150)
                let randomDateValue = randomDate()
                let newReading = GlucoseReading(glucose: glucoseValue, date: randomDateValue, notes: nil)
                
                modelContext.insert(newReading)
            }
        } else {
            // DELETE
            for reading in glucoseReadings {
                modelContext.delete(reading)
            }
            
            // CREATE
            for _ in 0..<50 {
                let glucoseValue = Int.random(in: 80...150)
                let randomDateValue = randomDate()
                let newReading = GlucoseReading(glucose: glucoseValue, date: randomDateValue, notes: nil)
                
                modelContext.insert(newReading)
            }
        }
        
    }
}

#Preview {
    GlucoseView()
}
