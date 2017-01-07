//
//  AccountViewController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
   
    @IBOutlet var tableView: UITableView!
    @IBOutlet var anonView: UIView!
    
    weak var signInPresenter: SignInPresenter?
    var currentUser: User?
    let identifiers = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        tableView.estimatedRowHeight = 180.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = currentUser {
            anonView.isHidden = true
            tableView.reloadData()
            navigationItem.rightBarButtonItem = nil
        }
        else {
            anonView.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: self, action: #selector(didTapSignIn))
        }
    }
    
    @objc fileprivate func didTapSignIn() {
        signInPresenter?.presentSignIn()
    }
}

extension AccountViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? AccountImageViewCell else { return UITableViewCell() }
            cell.profileImageView.image = #imageLiteral(resourceName: "nobody")
            return cell
        case (1, 0):
            // Name
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = "Kyle Yoon"
            return cell
        case (2, 0):
            // Sign Out
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = "Sign Out"
            cell.textLabel?.textColor = UIColor.red
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension AccountViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (2, 0):
            // Sign out
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}

extension AccountViewController: Authenticatable {
    
    func refresh(with user: User) {
        currentUser = user
        tableView.reloadData()
        anonView.isHidden = true
        navigationItem.rightBarButtonItem = nil
    }
    
}
