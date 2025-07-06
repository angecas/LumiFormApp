//
//  MockFetchDataDataSource.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//


@testable import LumiFormApp
import XCTest
import Combine

final class MockFetchDataDataSource: FetchDataDataSourceProtocol {
    var itemToReturn: Item?
    var shouldSucceed = true
    var mockScrollItems: [ScrollItem] = []

    func getData() async throws -> Item? {
        if shouldSucceed {
            return itemToReturn
        } else {
            throw NSError()
        }
    }

    func getContentData() async throws -> [ScrollItem] {
        if shouldSucceed {
            return mockScrollItems
        } else {
            throw NSError()
        }
    }
}
