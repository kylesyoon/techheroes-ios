//
//  HeroTabBarController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

/// Protocol for things that should update upon authentication
protocol Authenticatable: class {
    
    /// Hold the user to pass along
    var currentUser: User? { get set }
    
    func refresh(with user: User)
    
}

/// Protocol for things that can present a sign in UI
protocol SignInPresenter: class {
    
    func presentSignIn()
    
}

class RootTabBarController: UITabBarController {
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let heroesStoryboard = UIStoryboard(name: "Hero", bundle: nil)
        let accountStoryboard = UIStoryboard(name: "Account", bundle: nil)
        guard let heroNav = heroesStoryboard.instantiateInitialViewController() as? UINavigationController,
            let heroList = heroNav.viewControllers.first as? HeroListViewController,
            let accountNav = accountStoryboard.instantiateInitialViewController() as? UINavigationController,
            let account = accountNav.viewControllers.first as? AccountViewController else {
                return
        }
        let heroTab = UITabBarItem(title: NSLocalizedString("Hero", comment: "Hero"), image: nil, tag: 0)
        heroNav.tabBarItem = heroTab
        heroList.signInPresenter = self
        let accountTab = UITabBarItem(title: NSLocalizedString("Account", comment: "Account"), image: nil, tag: 1)
        accountNav.tabBarItem = accountTab
        account.signInPresenter = self
        viewControllers = [heroNav, accountNav]
    }
    
}

extension RootTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let nav = viewController as? UINavigationController,
            let vc = nav.visibleViewController as? Authenticatable {
            vc.currentUser = currentUser
        }
    }
    
}

extension RootTabBarController: SignInPresenter {
    
    func presentSignIn() {
        let signIn = SignInViewController(nibName: String(describing: SignInViewController.self), bundle: nil)
        signIn.delegate = self
        let nav = UINavigationController(rootViewController: signIn)
        nav.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                       target: self,
                                                                       action: #selector(SignInViewController.didTapCancel))
        present(nav, animated: true, completion: nil)
    }
    
}

extension RootTabBarController: SignInViewControllerDelegate {
    
    func viewController(viewController: SignInViewController, didSignInFor user: User) {
        currentUser = user
        dismiss(animated: true) {
            if let nav = self.selectedViewController as? UINavigationController,
                let vc = nav.visibleViewController as? Authenticatable {
                vc.refresh(with: user)
            }
        }
    }
    
    func didTapCancel(for viewController: SignInViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

