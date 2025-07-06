//
//  ScrollItem.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 06/07/2025.
//

import Foundation

struct ScrollItem: Codable, Hashable {
    let id: String
    let item: Item
    let depth: Int
}

extension ScrollItem {
    var isPageOrSection: Bool {
        item.type == .page || item.type == .section
    }
}

class ScrollState: ObservableObject {
    @Published var scrollToId: String?
}
