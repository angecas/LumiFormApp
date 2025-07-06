//
//  MockFetchService.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//
import XCTest
@testable import LumiFormApp

final class MockFetchService: FetchServiceProtocol {
    var shouldSucceed: Bool = true
    var mockItem: Item = Item(type: nil, title: nil, src: nil, items: nil)
    
    func getData() async throws -> Item? {
        if shouldSucceed {
            return mockItem
        } else {
            throw NSError()
        }
    }
}
