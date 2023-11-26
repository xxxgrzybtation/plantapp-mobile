//
//  PlantModel.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import Foundation

import Foundation

struct Plant: Identifiable, Codable {
    let id: String
    let name: String
    let measurement: [Measurement]
}

struct Measurement: Identifiable, Codable {
    var id = UUID()
    let date: TimeInterval // Representing timestamp as TimeInterval
    let value: Int
}

extension Plant {
    static let previewPlant = Plant(id: "123", name: "Stokrotka",
                                    measurement: [Measurement(date: 1678746800, value: 12),
                                                  Measurement(date: 1679756800, value: 50),
                                                  Measurement(date: 1689646800, value: 78)])
}
