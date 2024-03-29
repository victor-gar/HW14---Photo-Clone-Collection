//
//  SceneDelegate.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 30.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
               window = UIWindow(windowScene: windowScene)
               window?.rootViewController = MainTabBarViewController()
               window?.makeKeyAndVisible()
    }
}

