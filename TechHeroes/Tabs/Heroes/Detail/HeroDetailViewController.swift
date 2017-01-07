//
//  HeroDetailViewController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    @IBOutlet var detailStackView: UIStackView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var yearsLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var positionsStackView: UIStackView!
    
    var hero: TempHeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hero = hero else {
            return
        }
        
        nameLabel.text = hero.firstName + " " + hero.lastName
        imageView.image = #imageLiteral(resourceName: "nobody")
        
        let requestButton = UIBarButtonItem(title: "Request", style: .plain, target: self, action: #selector(HeroDetailViewController.didTapRequestButton))
        navigationItem.rightBarButtonItem = requestButton
    }
    
    @objc fileprivate func didTapRequestButton() {
        performSegue(withIdentifier: "requestSegue", sender: nil)
    }
    
}
