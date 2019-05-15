//
//  Helper.swift
//  Solemate
//
// This class is an extension to UITextField, creating a bottom border.
//
//  Created by Steven Tran on 5/9/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

extension UITextField {
    
    // Next step here
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.init(displayP3Red: 0, green: 0.60, blue: 0.8, alpha: 0.8).cgColor //lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
