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
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(glucoseReadings.sorted(by: { $0.date < $1.date })) { reading in
                    GlucoseListRowView(glucoseReading: reading)
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.theme.background)
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
