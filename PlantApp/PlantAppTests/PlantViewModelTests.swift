//
//  PlantViewModelTests.swift
//  PlantViewModelTests
//
//  Created by Remigiusz Makuchowski on 05/01/2024.
//

import XCTest
import Combine
@testable import PlantApp

final class PlantViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    let url = URL(string: "https://imaginaryNonExistentURL.com")!
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        cancellables.removeAll()
    }

    func test_ViewModel_getPlants_happyPath() {
        // Given
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "PlantMockData", withExtension: "json")!)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let service = PlantService(session: URLSessionMock(data: data, response: response), url: url)
        let vm = PlantViewModel(plantService: service)
    
        // When
        let expectation = XCTestExpectation(description: "Should return mocked data")
    
        vm.$allPlants
            .dropFirst()
            .sink { plant in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertFalse(vm.allPlants.isEmpty)
        XCTAssertEqual(vm.allPlants.count, 3)
    }
    
    func test_ViewModel_getPlants_throws_badResponseError() {
        // Given
        let data = Data() // Empty Data object
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        let service = PlantService(session: URLSessionMock(data: data, response: response), url: url)

           // When
        let expectation = XCTestExpectation(description: "Should throw badResponse error")
        let vm = PlantViewModel(plantService: service)
        
        vm.$error
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(vm.showAlert)
        XCTAssertEqual(vm.error as? CustomError, CustomError.badResponse)
    }
    
    func test_ViewModel_getPlants_corruptedData() {
        // Given
        let data = Data() // Empty Data object
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let service = PlantService(session: URLSessionMock(data: data, response: response), url: url)

           // When
        let expectation = XCTestExpectation(description: "Should throw decoding error")
        let vm = PlantViewModel(plantService: service)
        
        vm.$error
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(vm.showAlert)
        XCTAssertNotNil(vm.error)
    }

}
