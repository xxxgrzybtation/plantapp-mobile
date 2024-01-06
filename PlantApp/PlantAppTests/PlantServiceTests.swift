//
//  PlantServiceTests.swift
//  PlantAppTests
//
//  Created by Remigiusz Makuchowski on 06/01/2024.
//

import XCTest
import Combine
@testable import PlantApp

final class PlantServiceTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    let url = URL(string: "https://imaginaryNonExistentURL.com")!
    var returnedData: Data? = nil
        
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        cancellables.removeAll()
        returnedData = nil
    }
    
    func test_PlantService_download_happyPath() {
        // Given
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "PlantMockData", withExtension: "json")!)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let session = URLSessionMock(data: data, response: response)
        let service = PlantService(session: session, url: url)
        
        // When
        let expectation = XCTestExpectation(description: "Should not failed")
        let expectation2 = XCTestExpectation(description: "Should return data")
        
        service.download()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(_):
                    XCTFail("Completion should not failed")
                }
            } receiveValue: { [weak self] data in
                self?.returnedData = data
                expectation2.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 2)
        XCTAssertNotNil(returnedData)
        XCTAssertFalse(data.isEmpty)
    }
    
    func test_PlantService_download_throws_badResponseError() {
        // Given
        let data = Data() // Empty Data object
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        let service = PlantService(session: URLSessionMock(data: data, response: response), url: url)
        
        // When
        let expectation = XCTestExpectation(description: "Should fail")
        let expectation2 = XCTestExpectation(description: "Should throw badResponse error")
        
        service.download()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Completion should not failed")
                case .failure(let failure):
                    expectation.fulfill()
                    if failure as? CustomError == .badResponse {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { data in
                XCTFail("Should not receive any value")
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 2.0)
        XCTAssertNil(returnedData)
    }
    
}
