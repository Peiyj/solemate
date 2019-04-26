//
//  AccountInfoViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Verify all input fields are correctly filled
    @IBAction func nextOnPress(_ sender: Any) {
        self.performSegue(withIdentifier: "goToPersonalInfo", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
