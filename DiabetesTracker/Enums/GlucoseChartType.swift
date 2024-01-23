//
//  GlucoseChartType.swift
//  DiabetesTracker
//
//  Created by James Greiner on 1/17/24.
//

import Foundation

enum GlucoseChartType {
    case trend, range
}

extension GlucoseChartType: CustomStringConvertible {
    var description: String {
        switch self {
            case .trend:
                return "Trend"
            case .range:
                return "Range"
        }
    }
}
