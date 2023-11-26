//
//  PlantService.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import Foundation

class PlantService {
    
    func getData() -> Data {
        var jsonData = Data()
        if let jsonFilePath = Bundle.main.path(forResource: "PlantMockData", ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: jsonFilePath)
                // Now you have the JSON string from the file
                print(jsonString)
                jsonData = jsonString.data(using: .utf8)!
            } catch {
                print("Error reading JSON file: \(error)")
                return Data()
            }
        }
        return jsonData
    }
}
