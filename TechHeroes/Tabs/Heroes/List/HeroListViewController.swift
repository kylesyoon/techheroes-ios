//
//  ViewController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

typealias TempHeroModel = (firstName: String, lastName: String, discipline: String, position: String, company: String, years: Int, rating: String, rate: Double)

class HeroListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    var heroes = [TempHeroModel]()
    var disciplines = [String]()
    var selectedHero: TempHeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
        
        tableView.register(UINib(nibName: String(describing: HeroListTableViewHeaderView.self), bundle: nil),
                           forHeaderFooterViewReuseIdentifier: String(describing: HeroListTableViewHeaderView.self))
        tableView.register(UINib(nibName: String(describing: HeroListTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: HeroListTableViewCell.self))
        tableView.estimatedRowHeight = 107.0
        
        flowLayout.estimatedItemSize = CGSize(width: 100.0, height: 50.0)
        
        disciplines = ["Android", "iOS", "Web", "Systems"]
        
        heroes = [TempHeroModel("Kyle", "Yoon", "iOS", "Level 2 Engineer", "Vokal", 2, "5 Stars", 5.00),
                  TempHeroModel("Andrew", "Campbell", "Systems", "Backend Engineer", "EventUp", 2, "5 Stars", 50.00),
                  TempHeroModel("Jae", "Han", "Analytics", "Paid Search Analyst", "Crate & Barrel", 1, "1 Star", 0.00)]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let detail = segue.destination as? HeroDetailViewController {
                detail.hero = self.selectedHero
            }
        }
    }
    
}

extension HeroListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroListTableViewCell.self), for: indexPath) as? HeroListTableViewCell else {
            return UITableViewCell()
        }
        
        let hero = heroes[indexPath.section]
        cell.companyLabel.text = hero.company
        cell.positionLabel.text = hero.position
        cell.rateLabel.text = String(format: "%.2f/min", hero.rate)
        cell.yearsLabel.text = "\(hero.years) years"
        cell.ratingLabel.text = hero.rating
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(66.0)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}

extension HeroListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HeroListTableViewHeaderView.self)) as? HeroListTableViewHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        let hero = heroes[section]
        header.profileImageView.image = #imageLiteral(resourceName: "nobody")
        header.nameLabel.text = hero.firstName + " " + hero.lastName
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedHero = heroes[indexPath.section]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
}

extension HeroListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disciplines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroDisciplineCollectionViewCell.self), for: indexPath) as? HeroDisciplineCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.disciplineLabel.text = disciplines[indexPath.row]
        return cell
    }
    
}

extension HeroListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Change discipline of heroes
    }
    
}
