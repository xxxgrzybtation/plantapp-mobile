//
//  PlantViewModel.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 18/12/2023.
//

import Foundation
import Combine

class PlantViewModel: ObservableObject {
    @Published var allPlants: [Plant] = []
    @Published var showAlert = false
    @Published var error: Error? = nil
    
    private let plantDataService: PlantService
    private var cancellables: Set<AnyCancellable> = []
    
    init(plantService: PlantService = PlantService()) {
        self.plantDataService = plantService
        getPlants()
    }
    
    func getPlants() {
        plantDataService.download()
            .decode(type: [Plant].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { self.completionHandler($0) },
                  receiveValue: { [weak self] returnedPlants in
                self?.allPlants = returnedPlants
            })
            .store(in: &cancellables)
    }
    
    private func completionHandler(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            return
        case .failure(let failure):
            error = failure
            showAlert = true
        }
    }
}
