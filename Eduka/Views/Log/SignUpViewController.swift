//
//  SignUpViewController.swift
//  Eduka
//
//  Created by Celestial on 14/01/25.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    let shared = AuthManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        appleBtn.layer.cornerRadius = 15
        signInBtn.layer.cornerRadius = 15
        googleBtn.layer.cornerRadius = 15
        facebookBtn.layer.cornerRadius = 15
        
        profileImage.image = UIImage(systemName: Constants.personCircle)
    }
    
    

    @IBAction func cancel(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.customTabBarVC) as! CustomTabBarVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func signIn(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.loginVC) as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func signUp(_ sender: UIButton) {
        
        shared.login = true
        shared.logOut = false
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.customTabBarVC) as! CustomTabBarVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func uploadImage(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    

}

extension SignUpViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        profileImage.image = image
        profileImage.alpha = 1
//        uploadBtn.isHidden = true
        
    }
    
    
    
}
