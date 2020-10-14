//
//  TabbarController.swift
//  FinalProject
//
//  Created by Abcd on 10/3/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TabbarViewController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    // MARK: - Setup View Controllers
    private func setupTabbar() {
        let homeNavi = UINavigationController(rootViewController: ListPitchViewController())
        homeNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_home"), selectedImage: UIImage(named: "ic_tabbar_home"))
        homeNavi.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.2235294118, blue: 0.3215686275, alpha: 1)
        
        let favouriteVC = UINavigationController(rootViewController: FavouriteViewController())
        favouriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_favourite"), selectedImage: UIImage(named: "ic_tabbar_favourite"))
        favouriteVC.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.2235294118, blue: 0.3215686275, alpha: 1)
        
        let scheduleVC = UINavigationController(rootViewController: ScheduleViewController())
        scheduleVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_schedule"), selectedImage: UIImage(named: "ic_tabbar_schedule"))
        scheduleVC.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.2235294118, blue: 0.3215686275, alpha: 1)
        viewControllers = [homeNavi, scheduleVC, favouriteVC]
        tabBar.tintColor = #colorLiteral(red: 0.07058823529, green: 0.2235294118, blue: 0.3215686275, alpha: 1)
        tabBar.isTranslucent = true
        tabBar.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.2235294118, blue: 0.3215686275, alpha: 1)
    }
}
