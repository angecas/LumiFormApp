//
//  FetchDataDataSourceTests.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//

import XCTest
@testable import LumiFormApp

final class FetchDataDataSourceTests: XCTestCase {
    var fetchService: MockFetchService!
    var dataSource: FetchDataDataSource!

    override func setUpWithError() throws {
        fetchService = MockFetchService()
        dataSource = FetchDataDataSource(fetchService: fetchService)
        try? DiskCache<Item>(fileName: "item.json").clear()
    }

    override func tearDownWithError() throws {
        fetchService = nil
        dataSource = nil
    }

    func testFetchDataWhenSuccess() async throws {
        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: FetchDataDataSourceTests.self
        )
        fetchService.mockItem = expectedResponse
        fetchService.shouldSucceed = true

        let result = try await dataSource.getData()

        XCTAssertEqual(result, expectedResponse)
    }

    func testFetchDataWhenFails() async throws {
        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: FetchDataDataSourceTests.self
        )
        fetchService.mockItem = expectedResponse
        fetchService.shouldSucceed = false

        do {
            _ = try await dataSource.getData()
            XCTFail("Expected to throw but did not")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testGetContentDataWhenSuccess() async throws {
        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: FetchDataDataSourceTests.self
        )
        fetchService.mockItem = expectedResponse
        fetchService.shouldSucceed = true

        let contentData = try await dataSource.getContentData()

        XCTAssertFalse(contentData.isEmpty)
        XCTAssertEqual(contentData.first?.item.title, expectedResponse.title)
    }

    func testGetContentDataWhenFails() async throws {
        let expectedResponse = try MockHelper.loadMockFromJSON(
            named: "ResponseMock",
            responseType: Item.self,
            for: FetchDataDataSourceTests.self
        )
        fetchService.mockItem = expectedResponse
        fetchService.shouldSucceed = false
        
        do {
            let _ = try await dataSource.getContentData()
            XCTFail("Expected to throw but did not")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
