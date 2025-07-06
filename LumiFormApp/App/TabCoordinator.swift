//
//  TabCoordinator.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import UIKit

class TabCoordinator: TabBarCoordinator {
    enum Constants {
        static let firstTabImage: String = "text.line.first.and.arrowtriangle.forward"
        static let secondTabImage: String = "list.triangle"
    }

    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    let scrollState = ScrollState()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let mainPageNavigationController = UINavigationController()
        let mainPageCoordinator = MainPageCoordinator(
            navigationController: mainPageNavigationController,
            scrollState: scrollState
        )
        mainPageCoordinator.start()

        let contentsNavigationController = UINavigationController()
        let contentsCoordinator = ContentsCoordinator(
            navigationController: contentsNavigationController,
            scrollState: scrollState
        )
        contentsCoordinator.start()

        childCoordinators.append(mainPageCoordinator)
        childCoordinators.append(contentsCoordinator)

        mainPageNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("content", comment: ""), image: UIImage(systemName: Constants.firstTabImage), tag: 0)
        contentsNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("table", comment: ""), image: UIImage(systemName: Constants.secondTabImage), tag: 1)

        tabBarController.viewControllers = [mainPageNavigationController, contentsNavigationController]
    }
}
