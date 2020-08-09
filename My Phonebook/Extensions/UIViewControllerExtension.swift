//
//  UIViewControllerExtension.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/9/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true, completion: nil)
    }
}
