//
//  GlucoseListRowView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 1/29/24.
//

import SwiftUI

struct GlucoseListRowView: View {
    
    let glucoseReading: GlucoseReading
    
    var body: some View {
        glucoseListRow
    }
}

extension GlucoseListRowView {
    // MARK: Views
    private var glucoseListRow: some View {
        HStack {
            Text("\(glucoseReading.glucose)")
                .font(.title)
                .fontWeight(.semibold)
            Spacer()
            VStack(alignment: .leading) {
                Text(glucoseReading.date.formatDateAsString())
                Text(glucoseReading.date.formatTimeAsString())
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color.theme.background)
        .clipShape(.buttonBorder)
        .shadow(radius: 5)
    }
}

//#Preview {
//    GlucoseListRowView()
//}
