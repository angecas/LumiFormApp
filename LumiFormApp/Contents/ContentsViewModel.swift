//
//  ContentsViewController.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit
import SwiftUI
import Combine


import Combine
import Foundation
import SwiftUI

final class ContentsViewModel {
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var contents: [ScrollItem] = []

    private let fetchDataDataSource: FetchDataDataSourceProtocol
    
    init(fetchDataDataSource: FetchDataDataSourceProtocol) {
        self.fetchDataDataSource = fetchDataDataSource
    }
    
    func fetchData() async throws {
        contents = try await fetchDataDataSource.getContentData()        
    }
}
