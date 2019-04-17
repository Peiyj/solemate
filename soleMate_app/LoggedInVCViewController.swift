//
//  LoggedInVCViewController.swift
//  Solemate_app
//
//  Created by patrick on 2019/3/22.
//  Copyright © 2019 soleMate. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoggedInVCViewController: UIViewController {

    @IBAction func logoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch{
            print("there was a problem logging out")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
