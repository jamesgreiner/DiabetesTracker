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
    
    @State private var chartType: GlucoseChartType = .trend
    @State private var showingAddGlucoseView = false

    private let chartOptions: [GlucoseChartType] = [.trend, .range]
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                chartPicker
                chart
                addGlucoseButton
            }
            .onAppear(perform: populateGlucoseData)
            .sheet(isPresented: $showingAddGlucoseView) {
                AddGlucoseView()
            }
        }
    }
}

extension GlucoseView {
    // MARK: Views
    private var header: some View {
        ZStack {
            TabHeaderView(title: "Glucose")
            HStack {
                Spacer()
                NavigationLink("View Logs", destination: GlucoseListView())
                    .padding(.trailing)
            }
        }
    }
    
    private var chartPicker: some View {
        Picker("Chart Types", selection: $chartType) {
            ForEach(chartOptions, id: \.self) { option in
                Text(option.description)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    @ViewBuilder
    private var chart: some View {
        if chartType == .trend {
            GlucoseTrendView()
        }
        else if chartType == .range {
            GlucoseRangeView()
        }
    }
    
    private var addGlucoseButton: some View {
        Button {
            addGlucose()
        } label: {
            Text("Add Glucose")
                .frame(maxWidth: .infinity)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .clipShape(.buttonBorder)
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
                let glucoseValue = Int.random(in: 60...200)
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
                let glucoseValue = Int.random(in: 60...200)
                let randomDateValue = randomDate()
                let newReading = GlucoseReading(glucose: glucoseValue, date: randomDateValue, notes: nil)
                
                modelContext.insert(newReading)
            }
        }
    }
    
    private func addGlucose() {
        showingAddGlucoseView.toggle()
    }
}

#Preview {
    GlucoseView()
}
