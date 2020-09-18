//
//  AppDelegate.swift
//  FinalProject
//
//  Created by MBA0321 on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import GoogleSignIn
import UIKit
import Firebase

enum RootType {
    case login
    case tabbar
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = "88334627068-er61v3tc52giogff940bkj999l1aubus.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        window = UIWindow(frame: UIScreen.main.bounds)
        changeRoot(rootType: .login)
        window?.makeKeyAndVisible()
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            let userId = user.userID
            let name = user.profile.name
            let email = user.profile.email
            print("\(userId ?? "")")
            print("\(email ?? "no email"), \(name ?? "" )")
            changeRoot(rootType: .tabbar)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance()?.handle(url) ?? false
    }
    
    
    func changeRoot(rootType: RootType) {
        switch rootType {
            
        case .login:
            window?.rootViewController = LoginViewController()
        case .tabbar:
            window?.rootViewController = HomeViewController()
        }
    }
}

