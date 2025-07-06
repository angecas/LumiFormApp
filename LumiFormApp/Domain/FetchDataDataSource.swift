//
//  FlightDataSourceProtocol.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import Foundation

protocol FetchDataDataSourceProtocol {
    func getData() async throws -> Item?
    func getContentData() async throws -> [ScrollItem]
}

// MARK: - Flight Data Source Implementation
final class FetchDataDataSource: FetchDataDataSourceProtocol {
    private let fetchService: FetchServiceProtocol
    private let cache = DiskCache<Item>(fileName: "item.json")

    init(fetchService: FetchServiceProtocol = DataService()) {
        self.fetchService = fetchService
    }

    func getData() async throws -> Item? {
        if let cached = try? cache.load() {
            return cached
        }

        if let items = try await fetchService.getData() {
            try? cache.save(items)
            return items
        } else { return nil }
    }

    func getContentData() async throws -> [ScrollItem] {
        let items = try await getData()
        if let scrollItems = items?.getAllScrollIds() {
            return scrollItems
        } else { return [] }
    }
}
