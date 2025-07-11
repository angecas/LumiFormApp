//
//  ItemType.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import Foundation

// MARK: - ItemType

enum ItemType: String, Codable {
    case page
    case section
    case text
    case image
}
extension ItemType {
    
    func fontSize(forDepth depth: Int = 0) -> CGFloat {
        switch self {
        case .page:
            return 48
        case .section:
            return max(18, 40 - CGFloat(depth * 2))
        case .text:
            return 16
        case .image:
            return 18
        }
    }

    var questionType: QuestionType? {
        switch self {
        case .text:
            return .textBased
        case .image:
            return .imageBased
        default:
            return nil
        }
    }
}

// MARK: - Item Model

struct Item: Codable, Hashable {
    let type: ItemType?
    let title: String?
    let src: String?
    let items: [Item]?
}

extension Item {
    func scrollId(at depth: Int) -> ScrollItem {
        let uniqueHash = "\(hashValue)"
        let uniqueId = "\(type?.rawValue ?? "")-\(depth)-\(uniqueHash)"
        
        return ScrollItem(id: uniqueId, item: self, depth: depth)
    }

    func getAllScrollIds(at depth: Int = 0) -> [ScrollItem] {
        var result = [scrollId(at: depth)]
        
        if let children = items {
            for child in children {
                result += child.getAllScrollIds(at: depth + 1)
            }
        }

        return result
    }
}
