//
//  RoundImage.swift
//  My Phonebook
//
//  Created by Fatma Mohamed on 8/6/20.
//  Copyright © 2020 Fatma Mohamed. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundImage: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
           didSet{
               self.layer.borderWidth = borderWidth
           }
       }

       @IBInspectable var borderColor: UIColor = UIColor.clear{
           didSet{
               self.layer.borderColor = borderColor.cgColor
           }
       }
    
}
