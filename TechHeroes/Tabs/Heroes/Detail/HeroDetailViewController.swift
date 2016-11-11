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
    
    var hero: TempHeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = #imageLiteral(resourceName: "nobody")
        guard let hero = hero else {
            return
        }
        
        nameLabel.text = hero.firstName + " " + hero.lastName
    }
    
}
