//
//  SceneDelegate.swift
//  FinalProject
//
//  Created by MBA0321 on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var sideMenuManager: SideMenuManager {
        return SideMenuManager.defaultManager
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configSideMenu()
    }

}

extension SceneDelegate {
    
    private func configSideMenu() {
        let menu: SideMenuNavigationController = SideMenuNavigationController(rootViewController: MenuListController(with: ["HOME", "COLLECTION", "SCHEDULE", "FAVORITES"]))
        sideMenuManager.leftMenuNavigationController = menu
    }
}
