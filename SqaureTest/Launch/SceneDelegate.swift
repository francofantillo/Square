//
//  SceneDelegate.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let rootVC = EmployeeViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootNC
        self.window = window
        window.makeKeyAndVisible()
        print("application executed")
    }
}
