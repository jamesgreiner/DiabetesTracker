//
//  GlucoseListView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 12/1/23.
//

import SwiftData
import SwiftUI

struct GlucoseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var glucoseReadings: [GlucoseReading]
        
    var body: some View {
        List(glucoseReadings) { reading in
            // Create separate view
            HStack() {
                Text("\(reading.glucose)")
                    .font(.title)
                    .fontWeight(.semibold)
                    
                Spacer()
                VStack(alignment: .leading) {
                    Text(reading.date.formatDateAsString())
                    Text(reading.date.formatTimeAsString())
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    GlucoseListView()
}

extension GlucoseListView {
    // MARK: View components
    
    // MARK: Function
    
    
//    private func getGroupedReadings() -> [Date : [GlucoseReading]] {
//        var result: [(Date, [GlucoseReading])]
//        
//        let readingsGroupedByDate = Dictionary(grouping: glucoseReadings, by: { $0.timestamp })
//        
//        for date in readingsGroupedByDate.keys {
//            result.append((date, readingsGroupedByDate.values))
//        }
//    }
}
