//
//  PlantDetailView.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import SwiftUI
import Charts

struct PlantDetailView: View {
    let plant: Plant
    
    var body: some View {
        Chart {
            ForEach(plant.measurement) { dataPoint in
                BarMark(
                    x: .value("Date", Date.formatDateFromTimeInterval(dataPoint.date)),
                    y: .value("Value", dataPoint.value)
                )
            }
        }
        .frame(width: 300, height: 400)
        .chartYScale(domain: 0...100)
    }
}

#Preview {
    PlantDetailView(plant: Plant.previewPlant)
}
