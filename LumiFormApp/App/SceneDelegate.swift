//
//  SceneDelegate.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 03/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: TabBarCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
                
        let appCoordinator = TabCoordinator(tabBarController: tabBarController)
        self.coordinator = appCoordinator
        appCoordinator.start()
                
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }

}

