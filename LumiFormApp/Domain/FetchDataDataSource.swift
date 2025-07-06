//
//  FlightDataSourceProtocol.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import Foundation

protocol FetchDataDataSourceProtocol {
    func getData() async throws -> Item
    func getContentData() async throws -> [ScrollItem]
}

// MARK: - Flight Data Source Implementation
final class FetchDataDataSource: FetchDataDataSourceProtocol {
    private let fetchService: FetchServiceProtocol
    private let cache = DiskCache<Item>(fileName: "item.json")
    private let scrollIdCache = DiskCache<[ScrollItem]>(fileName: "scrollIds8.json")

    init(fetchService: FetchServiceProtocol = DataService()) {
        self.fetchService = fetchService
    }

    func getData() async throws -> Item {
        if let cached = try? cache.load() {
            return cached
        }

        let items = try await fetchService.getData()
        try? cache.save(items)
        try? scrollIdCache.save(items.getAllScrollIds())
        return items
    }

    func getContentData() async throws -> [ScrollItem] {
        if let cached = try? scrollIdCache.load() {
            return cached
        }

        let items = try await getData()

        let scrollItems = items.getAllScrollIds()

        try? scrollIdCache.save(scrollItems)

        return scrollItems
    }
}
