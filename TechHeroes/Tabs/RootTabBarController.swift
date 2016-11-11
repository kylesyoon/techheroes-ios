//
//  HeroTabBarController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        let heroesStoryboard = UIStoryboard(name: "Hero", bundle: nil)
        let accountStoryboard = UIStoryboard(name: "Account", bundle: nil)
        guard let heroNav = heroesStoryboard.instantiateInitialViewController() as? UINavigationController,
            let accountNav = accountStoryboard.instantiateInitialViewController() as? UINavigationController else {
                return
        }
        let heroTab = UITabBarItem(title: NSLocalizedString("Hero", comment: "Hero"), image: nil, tag: 0)
        heroNav.tabBarItem = heroTab
        let accountTab = UITabBarItem(title: NSLocalizedString("Account", comment: "Account"), image: nil, tag: 1)
        accountNav.tabBarItem = accountTab
        
        viewControllers = [heroNav, accountNav]
    }
    
}
