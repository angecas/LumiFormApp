//
//  QuestionViewControllerFactory.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit

enum QuestionViewControllerFactory {
    static func makeQuestionScreen(
        coordinator: QuestionCoordinator,
        item: Item
    ) -> UIViewController {
        let viewController = QuestionImageViewController(item: item)
        return viewController
    }
}
