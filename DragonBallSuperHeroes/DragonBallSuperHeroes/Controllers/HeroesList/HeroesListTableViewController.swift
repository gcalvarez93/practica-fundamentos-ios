//
//  HeroesListTableViewController.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 30/9/23.
//

import UIKit

class HeroesListTableViewController: UITableViewController {
    
    private let network = NetworkModel()
    
    var heroes: [Hero] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Héroes Dragon Ball"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(
            UINib(nibName: "HeroesListTableViewCell", bundle: nil),
            forCellReuseIdentifier: HeroesListTableViewCell.identifier
        )
        
        network.getHeroes(completion: { [weak self] result in
            guard case let .success(hero) = result else {
                return
            }
                          
            self?.heroes = hero
        })
    }
    
}

// MARK: - Data Source
extension HeroesListTableViewController {
    // Fijamos el tamaño de la Table View
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        heroes.count
    }
    
    // Capturamos la celda y añadimos un objeto
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HeroesListTableViewCell.identifier,
            for: indexPath
        ) as? HeroesListTableViewCell else {
            return UITableViewCell()
        }
        
        let hero = heroes[indexPath.row]
        cell.configure(with: hero)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - Delegate
extension HeroesListTableViewController {
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let hero = heroes[indexPath.row]
        
        let detail = HeroeDetailViewController(
            title: hero.name,
            description: hero.description,
            photo: hero.photo,
            hero: hero
        )
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController( detail , animated: true)
    }
}
