//
//  LoginViewController.swift
//  Eduka
//
//  Created by Celestial on 14/01/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    var shared = AuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appleBtn.layer.cornerRadius = 15
        signInBtn.layer.cornerRadius = 15
        googleBtn.layer.cornerRadius = 15
        facebookBtn.layer.cornerRadius = 15

    }
    
    @IBAction func cancelLogin(_ sender: UIButton) {
        //cancel login page and return to home
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.customTabBarVC) as! CustomTabBarVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func SignUp(_ sender: UIButton) {
        //open signup page
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.signUp) as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func forgotPassword(_ sender: UIButton) {
        //todo
        
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        if emailTextField.text == "aryansin1105@gmail.com" && passwordTextField.text == "12345678" {
            shared.login = true
            shared.logOut = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.customTabBarVC) as! CustomTabBarVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}
