//
//  MainPageRootView.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import SwiftUI

struct MainPageRootView: View {
    
    enum Constants {
        static let spacing: CGFloat = 8
    }

    let item: Item?
    let depth: Int = 0
    let action: ((Item) -> Void)?
    
    @EnvironmentObject var scrollState: ScrollState
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                ItemsComponentView(item: item, depth: depth, action: action)
                    .id(item?.scrollId(at: depth).id)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Constants.spacing)
            }
            
            .onChange(of: scrollState.scrollToId) { targetId in
                guard let targetId = targetId else { return }
                
                withAnimation {
                    proxy.scrollTo(targetId, anchor: .top)
                }
                scrollState.scrollToId = nil
            }
        }
        .accessibilityIdentifier("itemsComponentView")
    }
}
