//
//  AddGlucoseView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 12/1/23.
//

import SwiftUI

struct AddGlucoseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var glucose = ""
    @State private var date = Date.now
    @State private var notes = ""
    
    var body: some View {
        VStack {
            glucoseHeader
            
            HStack {
                Image(systemName: "drop.fill")
                    .font(.system(size: 75))
                    .foregroundStyle(.red)
                    .padding(.leading)
                
                TextField("000", text: $glucose)
                    .font(.system(size: 100))
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(uiColor: .systemGray5))
                    .shadow(
                        color: .primary.opacity(0.15),
                        radius: 50, x: 0, y: 0
                    )
            )
            .padding()
            dateHeader
            DatePicker("", selection: $date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            notesHeader
            TextField("", text: $notes)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Spacer()
            Button {
                saveGlucose()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .clipShape(.buttonBorder)
        }
    }
}

#Preview {
    AddGlucoseView()
}



extension AddGlucoseView {
    // MARK: View components
    private var glucoseHeader: some View {
        HStack {
            Text("Glucose")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top)
            Spacer()
        }
    }
    
    private var dateHeader: some View {
        HStack {
            Text("Date")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            Spacer()
        }
    }
    
    private var notesHeader: some View {
        HStack {
            Text("Notes")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            Spacer()
        }
    }
    
    // MARK: Functions
    private func saveGlucose() {
        guard let glucoseValue = Int(glucose) else { return }
                
        let newReading = GlucoseReading(glucose: glucoseValue, date: Date.now, notes: String())
        modelContext.insert(newReading)
        dismiss()
    }
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        return formatter
    }()
}

extension Date {
    func formatDateAsString() -> String {
        return DateFormatter.dateFormatter.string(from: self)
    }
    
    func formatTimeAsString() -> String {
        return DateFormatter.timeFormatter.string(from: self)
    }
}
