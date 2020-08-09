//
//  ViewContactViewController.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/9/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import UIKit
import CoreData

class ViewContactViewController: UIViewController {

    
    
    var contact: NSManagedObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactNamee.text = contact?.value(forKey: "name") as? String
        contactEmail.text = contact?.value(forKey: "email") as? String
        contactPhone.text = contact?.value(forKey: "phone") as? String
        contactNickname.text =  contact?.value(forKey: "nickname") as? String
        contactGender.text =  contact?.value(forKey: "gender") as? String
        
        let imageData = contact?.value(forKey: "photo") as? NSData
        contactImage.image = UIImage(data: imageData as! Data)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var contactImage: RoundImage!
    
    @IBOutlet weak var contactNamee: UILabel!
    
    @IBOutlet weak var contactPhone: UILabel!
    
    @IBOutlet weak var contactEmail: UILabel!
    
    @IBOutlet weak var contactNickname: UILabel!
    
    @IBOutlet weak var contactGender: UILabel!
    
    

}
