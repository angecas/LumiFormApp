//
//  MockHelper.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//

import XCTest
@testable import LumiFormApp

import Foundation

class MockHelper {
    
    static func loadMockFromJSON<T: Codable>(named fileName: String, responseType: T.Type, for testClass: AnyClass) throws -> T {
        let bundle = Bundle(for: testClass)
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Missing file: \(fileName).json")
        }
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(responseType.self, from: data)
        return decoded
    }
}
