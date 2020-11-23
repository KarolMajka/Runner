//
//  SceneDelegate.swift
//  Worksmile-app
//
//  Created by Karol Majka on 20/11/2020.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window =  window

        let appCoordinator = AppCoordinator(dependencies: .init(presentation: .window(window: window)))
        self.appCoordinator = appCoordinator

        appCoordinator.start()
    }
}
