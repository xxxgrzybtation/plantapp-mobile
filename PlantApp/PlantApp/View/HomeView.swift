//
//  ContentView.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = PlantViewModel()
    
    var body: some View {
        NavigationView {
            if vm.allPlants.isEmpty {
                ProgressView {
                    Text("Pobieranie danych, proszę czekać...")
                }
            } else {
                List {
                    ForEach(vm.allPlants, id: \.id) { plant in
                        NavigationLink(plant.name, destination: PlantDetailView(plant: plant))
                    }
                }
                .navigationTitle("Plant App")
            }
        }
        .alert(isPresented: $vm.showAlert, content: {
            Alert(title: Text(vm.error?.localizedDescription ?? "Wystąpił nieznany błąd"),
                  dismissButton: .cancel(Text("Spróbuj ponownie"),action: { vm.getPlants() }))
        })
    }
    
}

#Preview {
    HomeView()
}
