//
//  ItemsComponentView.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import SwiftUI

struct ItemsComponentView: View {
    
    enum Constants {
        static let spacing: CGFloat = 8
    }
    
    let item: Item?
    let depth: Int
    let action: ((Item) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            switch item?.type {
            case .page:
                PageComponentView(page: item, depth: depth + 1, action: action)
                    .id(item?.scrollId(at: depth).id)
                    .padding(.leading, CGFloat(depth) * Constants.spacing)
            case .section:
                SectionComponentView(section: item, depth: depth + 1, action: action)
                    .id(item?.scrollId(at: depth).id)
                    .padding(.leading, CGFloat(depth) * Constants.spacing)
            default:
                QuestionsComponentView(question: item, type: item?.type?.questionType, depth: depth + 1, action: action)
                    .id(item?.scrollId(at: depth).id)
                    .padding(.leading, CGFloat(depth) * Constants.spacing)
            }
        }
    }
}
