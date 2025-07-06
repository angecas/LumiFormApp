//
//  ContentsCoordinator.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit

class ContentsCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    var loadingOverlay: UIView?
    var scrollState: ScrollState
    
    init(navigationController: UINavigationController, scrollState: ScrollState) {
        self.navigationController = navigationController
        self.scrollState = scrollState
    }

    func start() {
        let contentsController = ContentsFactory.makeContentsScreen(scrollState: scrollState, coordinator: self)
        contentsController.title = NSLocalizedString("table_contents", comment: "")
        navigationController.pushViewController(contentsController, animated: true)
    }
}
