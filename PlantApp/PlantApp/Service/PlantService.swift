//
//  PlantService.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 19/11/2023.
//

import Foundation
import Combine

class PlantService {
    private let session: APIRequestProtocol
    private let url: URL
    
    init(session: APIRequestProtocol = URLSession.shared, url: URL = URL(string: "http://51.195.117.95:8000/plants")!) {
        self.session = session
        self.url = url
    }
    
    func download() -> AnyPublisher<Data, Error> {
        return session.apiResponse(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try self.handleURLResponse(output: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw CustomError.badResponse
        }
        return output.data
    }
}

enum CustomError: LocalizedError {
    case badResponse
    
    var errorDescription: String? {
        switch self {
        case .badResponse:
            "Otrzymano błędną odpowiedź z serwera :("
        }
    }
}
