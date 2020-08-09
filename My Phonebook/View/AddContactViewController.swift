//
//  AddContactViewController.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/5/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import UIKit


enum Gender: String {
    case male = "male"
    case female = "female"
}

protocol AddContactDelegate {
    func addContact(contact: String, phoneNumber: String, email: String,nickName: String ,image: UIImage, gender: String)
}


class AddContactViewController: UIViewController {
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var nickNameTF: UITextField!
    
    var imagePicker: ImagePicker!
    var gender: String = ""
    var delegate: AddContactDelegate?
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Actions
    
    @IBAction func chooseImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func maleAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
                
        } else {
            sender.isSelected = true
            femaleButton.isSelected = false
            self.gender = Gender.male.rawValue
            print(self.gender)
        }
        
    }
    
    @IBAction func femaleAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            maleButton.isSelected = false
            self.gender = Gender.female.rawValue
            print(self.gender)

        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneAction(_ sender: Any) {
        
        let name = nameTF.text ?? ""
        let phone = phoneTF.text ?? ""
        
        if name.isEmpty {
            self.showAlert(title: "Name is required", message: "Please enter contact name to continue.")
            return
        }
        if phone.isEmpty {
            self.showAlert(title: "Phone is required", message: "Please enter contact phone to continue.")
            return
        }
        
        
        let email = emailTF.text ?? ""
        let image = contactImageView.image ?? UIImage()
        let nickName = nickNameTF.text ?? ""
        delegate?.addContact(contact: name, phoneNumber: phone, email: email,nickName: nickName, image: image, gender: gender)
    }
}


extension AddContactViewController: ImagePickerDelegate  {
    func didSelect(image: UIImage?) {
        self.contactImageView.contentMode = .scaleAspectFill
        self.contactImageView.image = image
    }
}
