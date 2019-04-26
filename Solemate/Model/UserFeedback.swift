//
//  UserFeedback.swift
//  Solemate
//
//  Created by Steven Tran on 4/25/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class UserFeedback: UIViewController {
    func alert(Title: String, Message: String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        present(alert, animated: true, completion: nil)
    }
}
