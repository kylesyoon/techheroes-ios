//
//  HeroListHeaderReusableView.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class HeroListTableViewHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 25.0 // Measured from storyboard
        profileImageView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.white
    }
    
}
