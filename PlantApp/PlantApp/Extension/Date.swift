//
//  Date.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import Foundation

extension Date {
    
    static func formatDateFromTimeInterval(_ date: TimeInterval) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.string(from: Date(timeIntervalSince1970: date))
        }
}
