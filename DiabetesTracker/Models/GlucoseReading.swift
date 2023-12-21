//
//  GlucoseReading.swift
//  DiabetesTracker
//
//  Created by James Greiner on 11/28/23.
//

import Foundation
import SwiftData

@Model
final class GlucoseReading {
    var id: UUID
    var glucose: Int
    var date: Date
    var notes: String?
    
    init(glucose: Int, date: Date, notes: String?) {
        self.id = UUID()
        self.glucose = glucose
        self.date = date
        self.notes = notes
    }
}
