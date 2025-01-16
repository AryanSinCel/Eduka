//
//  SettingsViewController.swift
//  Eduka
//
//  Created by Celestial on 03/01/25.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet var settingView: [UIView]!
    let shared = AuthManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shared.isSignIn{
            logBtn.setTitle(" Log Out", for: .normal)
        }else{
            logBtn.setTitle(" Log In", for: .normal)
        }
        

        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        for v in settingView{
            v.layer.cornerRadius = 10
        }
    }
    @IBAction func log(_ sender: UIButton) {
        if shared.isSignIn{
            shared.logOut = true
            shared.login = false
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.loginVC) as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    

}
