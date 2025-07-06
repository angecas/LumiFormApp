//
//  SectionComponent.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import SwiftUI

struct SectionComponentView: View {
    enum Constants {
        static let spacing: CGFloat = 8
    }
    

    let action: ((Item) -> Void)?
    private let section: Item?
    let depth: Int
    
    init(section: Item?, depth: Int, action: ((Item) -> Void)?) {
        self.section = section
        self.depth = depth
        self.action = action
    }
    
    var body: some View {
        if let title = section?.title, let type = section?.type {
            VStack(alignment: .leading) {
                    Text(title)
                    .font(.system(size: type.fontSize(forDepth: depth)))
                
                ForEach(section?.items ?? [], id: \.self) { item in
                    ItemsComponentView(item: item, depth: depth, action: action)
                        .padding(.bottom, Constants.spacing)
                }
            }
        }
    }
}
