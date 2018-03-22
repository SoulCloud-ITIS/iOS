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
    @IBOutlet weak var scrollView: UIScrollView!
    var alertFactory: AlertFactoryProtocol!
    let errorMessage = "Enter correct fields"
    let titleMessage = "Error"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        alertFactory = AlertFactory()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = .zero
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
            } else {
               let alert =  self.alertFactory.getAlert(with: self.titleMessage, and: self.errorMessage)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
