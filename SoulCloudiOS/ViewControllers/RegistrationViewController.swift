//
//  RegistrationViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 18/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        ApiManager.instance.registerNewUser(with: email, and: password) { (isTrue) in
            if isTrue {
                DispatchQueue.main.async {
                    let loginViewController = LoginViewController.instantiate(fromAppStoryboard: .main)
                    self.present(loginViewController, animated: true, completion: nil)
                }
            }
        }
    }
}
