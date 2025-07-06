//
//  StationsEndpoint.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import Foundation

enum DataEndpoint: APIEndpoint {
    case getData
    
    var scheme: String { "https" }

    var host: String { "mocki.io" }

    var path: String { "/v1/f118b9f0-6f84-435e-85d5-faf4453eb72a" }

    var method: HTTPMethod { .get }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? { nil }
}
