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
        VStack {
            legend
                .padding(.bottom)
         
            chart
            .chartScrollableAxes(.horizontal)
            .padding()
            .navigationTitle(plant.name)
        }
        .padding()
    }
}

extension PlantDetailView {
    var legend: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Legenda:")
                    .font(.title)
                Group {
                    Text("Oś Y: Procentowa wilgotność gleby")
                    Text("Oś X: Data pomiaru")
                }
                .font(.subheadline)
            }
            Spacer()
        }
    }
    
    var chart: some View {
        Chart(plant.data, id: \.timestamp) {
            BarMark(
                x: .value("Date", $0.timestamp),
                y: .value("Value", $0.value), width: 8
            )
        }
        .chartYAxis {
            AxisMarks(
                format: Decimal.FormatStyle.Percent.percent.scale(1),
                values: [0, 25, 50, 75, 100]
            )
        }
    }
}

#Preview {
    PlantDetailView(plant: Plant.previewPlant)
}
