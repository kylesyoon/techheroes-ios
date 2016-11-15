//
//  Position.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/15/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import Foundation

struct Position {
    
    let id: String
    let title: String
    let company: Company
    let startDate: (Int, Int) // month, year
    let endDate: (Int, Int)
    let isCurrent: Bool
    let summary: String
    
}
