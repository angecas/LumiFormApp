//
//  PageComponent.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//
import SwiftUI

struct PageComponentView: View {
    enum Constants {
        static let spacing: CGFloat = 8
    }
    

    private let page: Item?
    let depth: Int
    private let action: ((Item) -> Void)?

    init(page: Item?, depth: Int, action: ((Item) -> Void)?) {
        self.page = page
        self.depth = depth
        self.action = action
    }

    var body: some View {
        if let page = page, let title = page.title, let size = page.type?.fontSize(forDepth: depth) {
                VStack(alignment: .leading) {
                    Text(title)
                            .font(.system(size: size))

                    ForEach(page.items ?? [], id: \.self) { item in
                        ItemsComponentView(item: item, depth: depth, action: action)
                            .padding(.bottom, Constants.spacing)
                    }
                }
        }
    }
}
