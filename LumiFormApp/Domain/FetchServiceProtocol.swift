//
//  FetchServiceProtocol.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//


import Foundation

// MARK: - Flight Service Protocol
protocol FetchServiceProtocol {
    func getData() async throws -> Item
}

// MARK: - Flight Service Implementation
final class DataService: FetchServiceProtocol {
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func getData() async throws -> Item {
        try await client.performRequest(DataEndpoint.getData)
    }
}
