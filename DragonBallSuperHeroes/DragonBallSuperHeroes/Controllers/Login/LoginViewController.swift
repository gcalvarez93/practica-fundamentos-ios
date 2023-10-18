//
//  LoginViewController.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 28/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let network = NetworkModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTapLogin(_ sender: Any) {
        let home = HeroesListTableViewController()
        
        
        
        network.login(
            user: userNameTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { [weak self] result in
            
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.navigationController?.setViewControllers([home], animated: true)
                    }
                    
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.noAuthorizetAlert()
                    }
            }
        }
    }
    
}
    
    
    
    //MARK: - Extensions
    extension LoginViewController {
        
        func noAuthorizetAlert() {
            let alert = UIAlertController(
                title: "Error",
                message: "Tu usuario o contraseña son incorrectos",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }


