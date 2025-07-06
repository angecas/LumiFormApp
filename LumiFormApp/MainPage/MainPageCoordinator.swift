//
//  MainPageCoordinator.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import UIKit

class MainPageCoordinator: Coordinator {

    var navigationController: UINavigationController
    let scrollState: ScrollState

    var loadingOverlay: UIView?
    
    init(navigationController: UINavigationController, scrollState: ScrollState) {
        self.navigationController = navigationController
        self.scrollState = scrollState
    }

    func start() {
        let mainViewController = MainViewControllerFactory.makeMainViewScreen(scrollState: scrollState, coordinator: self)
        mainViewController.title = NSLocalizedString("some_operation", comment: "")
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func showQuestionImage(item: Item) {
        let questionImageCoordinator = QuestionCoordinator(item: item, navigationController: navigationController)
        questionImageCoordinator.start()
    }
}
