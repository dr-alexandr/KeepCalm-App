//
//  SceneDelegate.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 28.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupScene(scene)
    }
    
    private func setupScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                window = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window?.windowScene = windowScene
                window?.rootViewController = AlertMainViewController()
                window?.makeKeyAndVisible()
    }
}

