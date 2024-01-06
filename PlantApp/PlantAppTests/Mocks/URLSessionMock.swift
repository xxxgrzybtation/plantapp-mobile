//
//  NetworkingManagerMock.swift
//  PlantAppUnitTests
//
//  Created by Remigiusz Makuchowski on 05/01/2024.
//

import Foundation
import Combine
@testable import PlantApp

class URLSessionMock: APIRequestProtocol {
    let data: Data
    let response: HTTPURLResponse
    
    init(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
    
    func apiResponse(for url: URL) -> AnyPublisher<APIResponse, URLError> {
        return Result.Publisher((data: data, response: response))
             .eraseToAnyPublisher()
    }
}
