//
//  ContentsRootView.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import SwiftUI

struct ContentsRootView: View {
    enum Constants {
        static let spacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 16
    }
    
    let action: ((String) -> Void)?
    let scrollItem: [ScrollItem]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                ForEach(scrollItem, id: \.self) { item in
                    if item.isPageOrSection, let title = item.item.title {
                        Text(title)
                            .padding(.leading, CGFloat(item.depth) * Constants.spacing)
                            .onTapGesture {
                                action?(item.id)
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Constants.spacing)
        }
    }
}
