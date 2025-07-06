//
//  MainPageViewModel.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import Combine
import Foundation
import SwiftUI

final class MainPageViewModel {
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var items: Item?

    private let fetchDataDataSource: FetchDataDataSourceProtocol
    
    init(fetchDataDataSource: FetchDataDataSourceProtocol) {
        self.fetchDataDataSource = fetchDataDataSource
    }
    
    func fetchData() async throws {
        items = try await fetchDataDataSource.getData()
    }
}
