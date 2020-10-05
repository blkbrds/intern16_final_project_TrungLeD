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
        
        let favouriteVC = UINavigationController(rootViewController: FavouriteViewController())
        favouriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_favourite"), selectedImage: UIImage(named: "ic_tabbar_favourite"))
        
        let scheduleVC = UINavigationController(rootViewController: ScheduleViewController())
        scheduleVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_schedule"), selectedImage: UIImage(named: "ic_tabbar_schedule"))
        viewControllers = [homeNavi, scheduleVC, favouriteVC]
        tabBar.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = true
    }
}
