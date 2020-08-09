//
//  ContactsListViewController.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/5/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import UIKit
import CoreData

class ContactsListViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var contactList: [NSManagedObject] = []
    var tempList: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddContact", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AddContactList") as! AddContactViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    
  
    override func viewWillAppear(_ animated: Bool) {
         guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return
         }
         
         let managedContext =
           appDelegate.persistentContainer.viewContext
         
         let fetchRequest =
           NSFetchRequest<NSManagedObject>(entityName: "Contact")
         
         do {
           contactList = try managedContext.fetch(fetchRequest)
            self.tempList = contactList
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
    }
    
}

extension ContactsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell",
                                          for: indexPath)
        cell.selectionStyle = .none
        let contact = contactList[indexPath.row]
        cell.textLabel?.text = contact.value(forKey: "name") as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            DatabaseHelper.instance.deleteContact(contact: contactList[indexPath.row])
            self.contactList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
}


extension ContactsListViewController: AddContactDelegate {
    func addContact(contact: String, phoneNumber: String, email: String, nickName: String, image: UIImage, gender: String) {
        self.dismiss(animated: true) {
            let image = image.pngData()
            DatabaseHelper.instance.saveContact(name: contact, nickName: nickName, phone: phoneNumber, image: image ?? Data(), gender: gender, completion: { contact in
                self.contactList.append(contact)
                self.tableView.reloadData()
            })
        }
    }
}

extension ContactsListViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let namePredicate = NSPredicate(format: "name contains[c] '\(searchText)'")
            let phonePredicate = NSPredicate(format: "phone contains[c] '\(searchText)'")
            let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, phonePredicate])
            DatabaseHelper.instance.fetchContact(predicate: compoundPredicate) { (filteredContactsList) -> (Void) in
                self.contactList = filteredContactsList
                self.tableView.reloadData()
            }
        } else {
            self.contactList = tempList
            self.tableView.reloadData()
        }
    }
}
