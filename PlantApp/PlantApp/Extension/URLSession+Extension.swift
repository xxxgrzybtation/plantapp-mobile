//
//  URLSession+Extension.swift
//  PlantApp
//
//  Created by Remigiusz Makuchowski on 05/01/2024.
//

import Foundation
import Combine

protocol APIRequestProtocol {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func apiResponse(for url: URL) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: APIRequestProtocol {
    func apiResponse(for url: URL) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}
