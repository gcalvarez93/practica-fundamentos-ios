//
//  TransformationsTableViewController.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 30/9/23.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
    
    private let transformations: [Transformation]
    
    init(transformations: [Transformation]) {
        self.transformations = transformations
        
        super.init(nibName: "TransformationsTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("TransformationsTableViewController(coder:) has not been implemented")
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"
        self.tableView.register(
            UINib(nibName: "TransformationsTableViewCell", bundle: nil),
            forCellReuseIdentifier: TransformationsTableViewCell.identifier
        )
    }
    
}

// MARK: - Data Source
extension TransformationsTableViewController {
    
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.transformations.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TransformationsTableViewCell.identifier,
            for: indexPath
        ) as? TransformationsTableViewCell else {
            return UITableViewCell()
        }
        
        let transformation = transformations[indexPath.row]
        
        cell.configure(transformation: transformation)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - Actions
extension TransformationsTableViewController {
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let transformation = transformations[indexPath.row]
        let details = HeroeDetailViewController(
            title: transformation.name,
            description: transformation.description,
            photo: transformation.photo,
            hero: nil
        )
        
        self.navigationController?.pushViewController(details, animated: true)
    }
}
