//
//  InformationViewController.swift
//  Solemate_app
//
//  Created by patrick on 2019/2/27.
//  Copyright © 2019 soleMate. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    //create an outlet for age
    @IBOutlet weak var ageField: UITextField!
    //create an outlet for gender
    @IBOutlet weak var genderField: UITextField!
    //create an outlet for height
    @IBOutlet weak var heightField: UITextField!
    //create an outlet for weight
    @IBOutlet weak var weightField: UITextField!
    
    var ageText = ""
    var genderText = ""
    var heightText = ""
    var weightText = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //try to see if "age" is modified
        let ageObject = UserDefaults.standard.object(forKey: "age")
        if let age = ageObject as? String {
            //if "age" is modified as string, modify the text field
            ageField.text = age
        }
        //try to see if "gender" is modified
        let genderObject = UserDefaults.standard.object(forKey: "gender")
        if let gender = genderObject as? String {
            //if "gender" is modified as string, modify the text field
            genderField.text = gender
        }
        //try to see if "height" is modified
        let heightObject = UserDefaults.standard.object(forKey: "height")
        if let height = heightObject as? String {
            //if "height" is modified as string, modify the text field
            heightField.text = height
        }
        //try to see if "weight" is modified
        let weightObject = UserDefaults.standard.object(forKey: "weight")
        if let weight = weightObject as? String {
            //if "weight" is modified as string, modify the text field
            weightField.text = weight
        }
        
    }
    
    //create an action for the button named "save"
    @IBAction func save(_ sender: Any) {
        //assign age text field to the key age
        UserDefaults.standard.set(ageField.text, forKey: "age")
        //assign gender text field to the key gender
        UserDefaults.standard.set(genderField.text, forKey: "gender")
        //assign age height field to the key height
        UserDefaults.standard.set(heightField.text, forKey: "height")
        //assign weight text field to the key weight
        UserDefaults.standard.set(weightField.text, forKey: "weight")
    }
    //create an action for the button named "done"
    @IBAction func done(_ sender: Any) {
        self.ageText = ageField.text!
        self.genderText = genderField.text!
        self.heightText = heightField.text!
        self.weightText = weightField.text!
        
        performSegue(withIdentifier: "profile", sender: self)
    }
    
    //send the data from the VC to another VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! profileViewController
        vc.finalAge = self.ageText
        vc.finalGender = self.genderText
        vc.finalHeight = self.heightText
        vc.finalWeight = self.weightText
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigat ion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
