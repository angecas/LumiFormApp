//
//  MainPageViewModelTest.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//

import XCTest
@testable import LumiFormApp
import Combine

final class MainPageViewModelTests: XCTestCase {
    var viewModel: MainPageViewModel!
    var mockDataSource: MockFetchDataDataSource!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockDataSource = MockFetchDataDataSource()
        viewModel = MainPageViewModel(fetchDataDataSource: mockDataSource)
    }

    override func tearDown() {
        viewModel = nil
        mockDataSource = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchDataSuccess() async throws {
        // Arrange
        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: MainPageViewModelTests.self
        )
        mockDataSource.itemToReturn = expectedResponse
        mockDataSource.shouldSucceed = true

        // Act
        try await viewModel.fetchData()

        // Assert
        XCTAssertEqual(viewModel.items?.title, "Main Page")
    }

    func testFetchDataFailure() async throws {
        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: MainPageViewModelTests.self
        )
        mockDataSource.itemToReturn = expectedResponse
        mockDataSource.shouldSucceed = false

        do {
            try await viewModel.fetchData()
            XCTFail("Expected to throw but it did not")
        } catch {
            XCTAssertNil(viewModel.items)
        }
    }
}
