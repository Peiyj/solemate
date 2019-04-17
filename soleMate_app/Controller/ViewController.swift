//
//  ViewController.swift
//  Solemate_app
//
//  Created by patrick on 2019/2/22.
//  Copyright © 2019 soleMate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    //create two outlets for username and password
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBAction func login(_ sender: Any) {
        //assign username text field to the key username
        UserDefaults.standard.set(usernameField.text, forKey: "username")
        //assign password text field to the key password
        UserDefaults.standard.set(passwordField.text, forKey: "password")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //try to see if "username" is modified
        let usernameObject = UserDefaults.standard.object(forKey: "username")
        if let username = usernameObject as? String {
            //if "username" is modified as string, modify the text field
            usernameField.text = username
        }
        //try to see if "gender" is modified
        let passwordObject = UserDefaults.standard.object(forKey: "password")
        if let password = passwordObject as? String {
            //if "gender" is modified as string, modify the text field
            passwordField.text = password
        }
    }


}

