//
//  ContentView.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import SwiftUI

struct ContentView: View {
    private let plantService = PlantService()
    @State private var plants: [Plant] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(plants, id: \.id) { plant in
                    NavigationLink(plant.name, destination: PlantDetailView(plant: plant))
                }
            }
        }
        .onAppear {
            let data = plantService.getData()
            do {
                plants = try JSONDecoder().decode([Plant].self, from: data)
            } catch {
                print("Cannot decode json: \(error), data: \(data)")
            }
        }
    }
}

#Preview {
    ContentView()
}
