//
//  profileViewController.swift
//  Solemate_app
//
//  Created by patrick on 2019/2/27.
//  Copyright © 2019 soleMate. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    //create four outlets
    @IBOutlet weak var ageField: UILabel!
    @IBOutlet weak var heightField: UILabel!
    @IBOutlet weak var genderField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    
    var finalAge = ""
    var finalHeight = ""
    var finalGender = ""
    var finalWeight = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ageField.text = finalAge
        heightField.text = finalHeight
        genderField.text = finalGender
        weightField.text = finalWeight
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
