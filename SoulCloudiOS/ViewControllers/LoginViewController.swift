//
//  LoginViewController.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 18/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var token = ""
    let errorMessage = "Enter correct login/password"
    let titleMessage = "Error"
    var alertFactory: AlertFactoryProtocol!
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        ApiManager.instance.loginUser(with: email, and: password) { (token, isTrue) in
            if isTrue {
                self.token = token
                ApiManager.instance.userToken = token
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(tabbarVC, animated: false, completion: nil)
                }
                print(self.token)
            }
            else {
                DispatchQueue.main.async {
                    let alert = self.alertFactory.getAlert(with: self.titleMessage, and: self.errorMessage)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}
