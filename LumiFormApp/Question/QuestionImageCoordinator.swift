//
//  QuestionCoordinator.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import UIKit

class QuestionCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var loadingOverlay: UIView?
    var item: Item
    
    init(item: Item, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.item = item
    }
    
    func start() {
        let questionImageViewController = QuestionViewControllerFactory.makeQuestionScreen(coordinator: self,
                                                                                           item: item
        )
        questionImageViewController.title = item.type?.rawValue.capitalized
        navigationController.pushViewController(questionImageViewController, animated: true)
    }
}
