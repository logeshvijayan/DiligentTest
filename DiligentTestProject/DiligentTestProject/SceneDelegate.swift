//
//  SceneDelegate.swift
//  DiligentTestProject
//
//  Created by Logesh Vijayan on 2022-08-31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
       let drawingViewController = PaintingListRouter.createPaintingListModule()
      
        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController()
        navigationController.viewControllers = [drawingViewController]
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

}

