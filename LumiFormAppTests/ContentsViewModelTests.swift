//
//  ContentsViewModelTests 2.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//

import XCTest
@testable import LumiFormApp
import Combine

final class ContentsViewModelTests: XCTestCase {
    var viewModel: ContentsViewModel!
    var mockDataSource: MockFetchDataDataSource!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockDataSource = MockFetchDataDataSource()
        viewModel = ContentsViewModel(fetchDataDataSource: mockDataSource)
    }

    override func tearDown() {
        viewModel = nil
        mockDataSource = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchDataSuccess() async throws {
        // Arrange
        let item = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: ContentsViewModelTests.self
        )

        let scrollItem = item.getAllScrollIds()
        mockDataSource.mockScrollItems = scrollItem
        mockDataSource.shouldSucceed = true

        // Act
        try await viewModel.fetchData()

        // Assert
        XCTAssertEqual(viewModel.contents.count, 13)
        XCTAssertEqual(13, Set(scrollItem.map({$0.id})).count)
        XCTAssertEqual(viewModel.contents.first?.item.title, "Main Page")
    }

    func testFetchDataFailure() async throws{

        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: ContentsViewModelTests.self
        )
        mockDataSource.shouldSucceed = false

        do {
            try await viewModel.fetchData()
            XCTFail("Expected to throw but it did not")
        } catch {
            XCTAssertEqual(viewModel.contents.count, 0)
        }
    }
}
