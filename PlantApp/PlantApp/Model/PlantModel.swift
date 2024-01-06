//
//  PlantModel.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import Foundation

import Foundation

struct Plant: Identifiable, Codable {
    var id: UUID? = UUID()
    let name: String
    let data: [Measurement]
    
    init(name: String, data: [Measurement]) {
        self.name = name
        self.data = data
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.data = try container.decode([Measurement].self, forKey: .data)
    }
}

struct Measurement: Identifiable, Codable {
    var id: UUID? = UUID()
    let timestamp: Date // Convert Timestamp to date format
    let value: Int
    
    init(date: Date, value: Int) {
        self.timestamp = date
        self.value = value
    }
    
    enum CodingKeys: CodingKey {
        case id
        case timestamp
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(Int.self, forKey: .value)
        let timestampData = try container.decode(Int.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: TimeInterval(timestampData))
    }
}

extension Plant {
    static let previewPlant = Plant(
        name: "Stokrotka",
        data: [
            Measurement(date: Date(timeIntervalSince1970: 1702684527), value: 10),
            Measurement(date: Date(timeIntervalSince1970: 1702688127), value: 77),
            Measurement(date: Date(timeIntervalSince1970: 1702691727), value: 83),
            Measurement(date: Date(timeIntervalSince1970: 1702695327), value: 94),
            Measurement(date: Date(timeIntervalSince1970: 1702698927), value: 64),
            Measurement(date: Date(timeIntervalSince1970: 1702702527), value: 99),
            Measurement(date: Date(timeIntervalSince1970: 1702706127), value: 83),
            Measurement(date: Date(timeIntervalSince1970: 1702709727), value: 54),
            Measurement(date: Date(timeIntervalSince1970: 1702713327), value: 51),
            Measurement(date: Date(timeIntervalSince1970: 1702716927), value: 17),
            Measurement(date: Date(timeIntervalSince1970: 1702720527), value: 32),
            Measurement(date: Date(timeIntervalSince1970: 1702724127), value: 23),
            Measurement(date: Date(timeIntervalSince1970: 1702727727), value: 12),
            Measurement(date: Date(timeIntervalSince1970: 1702731327), value: 28),
            Measurement(date: Date(timeIntervalSince1970: 1702734927), value: 9),
            Measurement(date: Date(timeIntervalSince1970: 1702738527), value: 62),
            Measurement(date: Date(timeIntervalSince1970: 1702742127), value: 81),
            Measurement(date: Date(timeIntervalSince1970: 1702745727), value: 85),
            Measurement(date: Date(timeIntervalSince1970: 1702749327), value: 23),
            Measurement(date: Date(timeIntervalSince1970: 1702752927), value: 36),
            Measurement(date: Date(timeIntervalSince1970: 1702756527), value: 45),
            Measurement(date: Date(timeIntervalSince1970: 1702760127), value: 10),
            Measurement(date: Date(timeIntervalSince1970: 1702763727), value: 98),
            Measurement(date: Date(timeIntervalSince1970: 1702767327), value: 90)
        ]
    )
}
