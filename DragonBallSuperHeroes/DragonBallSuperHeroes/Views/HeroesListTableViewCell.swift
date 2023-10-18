//
//  HeroesListTableViewCell.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 28/9/23.
//

import UIKit

class HeroesListTableViewCell: UITableViewCell {
    
    static let identifier = "HeroesListTableViewCell"

    @IBOutlet weak var imageUrl: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    func configure(with hero: Hero) {
        title.text = hero.name
        body.text = hero.description
        imageUrl.setImage(for: hero.photo)
    }
}
