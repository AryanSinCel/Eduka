//
//  ProfileViewController.swift
//  Eduka
//
//  Created by Celestial on 02/01/25.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileInfoEmail: UILabel!
    @IBOutlet weak var profileInfoContact: UILabel!
    @IBOutlet weak var profileInfoName: UILabel!
    @IBOutlet weak var profileInfoPassword: UILabel!
    @IBOutlet weak var editableView: UIView!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var profileInfoView: UIView!
    @IBOutlet weak var upgradePlanBtn: UIButton!
    @IBOutlet weak var planView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let name = UserDefaults.standard.string(forKey: Constants.userProfileName) ?? "Name"
        let email = UserDefaults.standard.string(forKey: Constants.userProfileEmail ) ?? "Email"
        let contact = UserDefaults.standard.string(forKey: Constants.userProfileContact) ?? "Contact"
        let imageData = UserDefaults.standard.data(forKey: Constants.userProfileImage)
        let password = UserDefaults.standard.string(forKey: Constants.userProfilePassword) ?? "Password"
        
        nameLabel.text = name
        profileInfoEmail.text = email
        profileInfoContact.text = contact
        profileInfoName.text = name
        profileInfoPassword.text = password
        
            
            if let imageData = imageData, let image = UIImage(data: imageData) {
                imageView.image = image
            } else {
                imageView.image = UIImage(systemName: Constants.personCircle)
            }
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        planView.layer.cornerRadius = 15
        upgradePlanBtn.backgroundColor = .red
        upgradePlanBtn.layer.cornerRadius = 15
        profileInfoView.layer.cornerRadius = 15
        imageBtn.isHidden = true
        editableView.isHidden = true
        
        
        emailTextField.paddingToTextField()
        nameTextField.paddingToTextField()
        passwordTextField.paddingToTextField()
        contactTextField.paddingToTextField()
        
        emailTextField.borderStyle = .none
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.clipsToBounds = true
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.borderStyle = .none
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.masksToBounds = true
        
        nameTextField.borderStyle = .none
        nameTextField.layer.cornerRadius = 20
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.clipsToBounds = true
        nameTextField.layer.masksToBounds = true
        
        contactTextField.borderStyle = .none
        contactTextField.layer.cornerRadius = 20
        contactTextField.layer.borderWidth = 1
        contactTextField.layer.borderColor = UIColor.gray.cgColor
        contactTextField.clipsToBounds = true
        contactTextField.layer.masksToBounds = true
        
        cancelBtn.layer.backgroundColor = UIColor.systemGray6.cgColor
        cancelBtn.layer.cornerRadius = 20
        
        saveBtn.layer.backgroundColor = UIColor.systemMint.cgColor
        saveBtn.layer.cornerRadius = 20
        
    }
    
    @IBAction func upgradePlan(_ sender: UIButton) {
        
        
    }
    
    @IBAction func changeProfile(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    
    @IBAction func editProfile(_ sender: UIButton) {
    
        imageView.alpha = 0.2
        imageBtn.isHidden = false
        editableView.isHidden = false
    }
    
    
    @IBAction func cancelEditting(_ sender: UIButton) {
        editableView.isHidden = true
        profileInfoView.isHidden = false
        imageView.alpha = 1
        imageBtn.isHidden = true
    }
    
    
    @IBAction func saveEditing(_ sender: UIButton) {
        
            let name = nameTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let contact = contactTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let imageData = imageView.image?.pngData()
            
        UserDefaults.standard.set(imageData, forKey: Constants.userProfileImage)
            
        
        if name.count > 0{
            UserDefaults.standard.set(name, forKey: Constants.userProfileName)
            profileInfoName.text = name
        }
        if password.count > 0{
            UserDefaults.standard.set(password, forKey: Constants.userProfilePassword)
            profileInfoPassword.text = password
        }
        if email.count > 0{
            UserDefaults.standard.set(email, forKey: Constants.userProfileEmail)
            profileInfoEmail.text = email
            
        }
        if contact.count > 0{
            UserDefaults.standard.set(contact, forKey: Constants.userProfileContact)
            profileInfoContact.text = contact
        }
            
            nameLabel.text = name
            
            editableView.isHidden = true
            profileInfoView.isHidden = false
            imageView.alpha = 1
            imageBtn.isHidden = true
        
        
    }
    
    
}

extension ProfileViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        imageView.image = image
        imageView.alpha = 1
        imageBtn.isHidden = true
        
    }
    
    
    
}

extension UITextField{
    func paddingToTextField(){
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
