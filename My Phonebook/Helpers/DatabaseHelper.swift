//
//  DatabaseHelper.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/5/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    static let instance = DatabaseHelper()
    
        
    
    let managedContext =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
   
    
    func saveContact(name: String, nickName: String, phone: String,image: Data, gender: String,email: String, completion: ( _ contact: NSManagedObject) -> Void) {
        
        let entity =
               NSEntityDescription.entity(forEntityName: "Contact",
                                          in: managedContext!)!
           
        let contact = NSManagedObject(entity: entity,
                                      insertInto: managedContext) as! Contact
        contact.setValue(name, forKeyPath: "name")
        contact.setValue(nickName, forKey: "nickname")
        contact.setValue(phone, forKey: "phone")
        contact.setValue(gender, forKey: "gender")
        contact.setValue(image, forKey: "photo")
        contact.setValue(email, forKey: "email")
        
        do {
            try managedContext?.save()
            completion(contact)
          //  contactList.append(contact)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchContact(predicate: NSPredicate, completion: (_ filteredContacts: [NSManagedObject]) -> (Void)) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        fetchRequest.predicate = predicate
        do {
            let contacts = try managedContext?.fetch(fetchRequest) as! [NSManagedObject]
            completion(contacts)
        } catch let error as NSError {
            print("Could not search data")
        }
    }
    
    
    func deleteContact(contact: NSManagedObject) {
        managedContext?.delete(contact)
        
        do {
            try managedContext?.save()
        } catch {
            print("Error in deleting")
        }
    }
}
