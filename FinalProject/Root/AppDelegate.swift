//
//  AppDelegate.swift
//  FinalProject
//
//  Created by MBA0321 on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu
enum RootType {
    case login
    case collection
}
    @UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        changeRoot(rootType: .collection)
        window?.makeKeyAndVisible()
        return true
    }
    
    func changeRoot(rootType: RootType) {
        switch rootType {
        case .login:
            window?.rootViewController = LoginViewController()
        case .collection:
            let navi = UINavigationController(rootViewController: DetailViewController())
            window?.rootViewController = navi
        }
    }
    
    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()
}
