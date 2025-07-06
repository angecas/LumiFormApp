//
//  QuestionsComponent.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit
import SwiftUI

enum QuestionType {
    case imageBased
    case textBased
}

struct QuestionsComponentView: View {
    
    enum Constants {
        static let spacing: CGFloat = 8
        static let imageSize: CGFloat = 170
    }
    
    private let type: QuestionType?
    private let question: Item?
    private let action: ((Item) -> Void)?
    let depth: Int

    init(question: Item?, type: QuestionType?, depth: Int, action: ((Item) -> Void)?) {
        self.action = action
        self.type = type
        self.question = question
        self.depth = depth
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let type = type, let question = question {
                switch type {
                case .imageBased:
                    if let imageString = question.src {
                        AsyncImage(url: URL(string: imageString)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: Constants.imageSize, height: Constants.imageSize)
                        .onTapGesture {
                            action?(question)
                        }
                    }
                    ForEach(question.items ?? [], id: \.self) { item in
                        ItemsComponentView(item: item, depth: depth, action: action)
                            .padding(.bottom, Constants.spacing)
                    }
                    
                case .textBased:
                    if let questionText = question.title, let type = question.type {
                            Text(questionText)
                            .font(.system(size: type.fontSize(forDepth: depth)))
                    }
                    
                    ForEach(question.items ?? [], id: \.self) { item in
                        ItemsComponentView(item: item, depth: depth, action: action)
                            .padding(.bottom, Constants.spacing)
                    }
                }
            }
        }
    }
}
