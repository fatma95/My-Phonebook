//
//  ViewController.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/4/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    
    var contacts: [NSManagedObject] = []
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        nameTF.returnKeyType = .done
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Actions
    
    @IBAction func showNextView(_ sender: Any) {
        
        if !nameTF.hasText {
            self.showAlert(title: "Username is required", message: "Please enter your name to continue.")
        }
        
        let storyboard = UIStoryboard(name: "ContactsList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContactsList") as! ContactsListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "loggedIn")
    }
    
    @IBAction func showPicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ViewController: ImagePickerDelegate  {
    func didSelect(image: UIImage?) {
        self.userImageView.contentMode = .scaleAspectFill
        self.userImageView.image = image
    }
}
