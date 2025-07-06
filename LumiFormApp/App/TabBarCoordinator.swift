//
//  TabBarCoordinator.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import UIKit

protocol TabBarCoordinator: AnyObject {
    var tabBarController: UITabBarController { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()
}
