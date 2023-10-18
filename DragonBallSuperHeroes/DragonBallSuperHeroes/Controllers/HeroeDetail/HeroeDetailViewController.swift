//
//  HeroeDetailViewController.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 30/9/23.
//

import UIKit

class HeroeDetailViewController: UIViewController {
    
    private var header: String
    private var desc: String
    private var photo: URL
    private var hero: Hero?
    private var transformations: [Transformation] = []
    private let network = NetworkModel()
    
    init(
        title: String,
        description: String,
        photo: URL,
        hero: Hero?
    ) {
        self.header = title
        self.desc = description
        self.photo = photo
        self.hero = hero
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var heroeImage: UIImageView!
    
    @IBOutlet weak var heroeName: UILabel!
    
    @IBOutlet weak var heroeDescription: UILabel!
    
    @IBOutlet weak var transformationsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformationsButton.isHidden = true
        
        heroeImage.setImage(for: photo)
        heroeDescription.text = desc
        title = header
        
        if let dragonBall = hero {
            network.getTransformations(for: dragonBall) { [weak self] result in
                guard case let .success( transformations ) = result else {
                    return
                }
                
                self?.transformations = transformations
                DispatchQueue.main.async {
                    self?.transformationsButton.isHidden = transformations.count == 0
                }
            }
        }
        
    }
   
    @IBAction func didTapTransformations(_ sender: Any) {
        let transformationsController =
        TransformationsTableViewController(transformations: self.transformations)
        
        self.navigationController?.pushViewController(transformationsController, animated: true)
    }
}
    
    
        

    

