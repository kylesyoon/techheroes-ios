//
//  User.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/15/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import Foundation

struct User {
    
    let id: String
    let firstName: String
    let lastName: String
    let headline: String
    let industry: String
    let connectionsCount: Int
    let summary: String
    let specialties: String
    let positions: [Position]
    let smallImageURL: String
    let bigImageURLs: [String]
    let publicProfileURL: String
    let location: (String, String) // code, name
    
}
