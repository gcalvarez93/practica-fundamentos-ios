//
//  TransformationsTableViewCell.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 30/9/23.
//

import UIKit

class TransformationsTableViewCell: UITableViewCell {

    static let identifier: String = "TransformationsTableViewCell"
    
    @IBOutlet weak var transformationName: UILabel!
    
    @IBOutlet weak var transformationDescription: UILabel!
    
    
    
    func configure(transformation: Transformation) {
        transformationName.text = transformation.name
        transformationDescription.text = transformation.description
    }
    
    
}
