//
//  ContentsCoordinator.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit

class ContentsCoordinator: Coordinator {
    enum Constants {
        static let title: String = "Table of Contents"
    }

    var navigationController: UINavigationController
    
    var loadingOverlay: UIView?
    var scrollState: ScrollState
    
    init(navigationController: UINavigationController, scrollState: ScrollState) {
        self.navigationController = navigationController
        self.scrollState = scrollState
    }

    func start() {
        let contentsController = ContentsFactory.makeContentsScreen(scrollState: scrollState, coordinator: self)
        contentsController.title = Constants.title
        navigationController.pushViewController(contentsController, animated: true)
    }
}
