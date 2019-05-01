//
//  AccountInfoViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    // IBOutlet Declarations
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightController: UISegmentedControl!
    @IBOutlet weak var weightController: UISegmentedControl!
    
    // local Variable Declarations
    var genderArr = ["Male", "Female"]
    var picker = UIPickerView()
    var isKg = false
    var isCm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        genderTextField.inputView = picker
        
        self.fNameTextField.delegate = self
        self.lNameTextField.delegate = self
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self
        self.dayTextField.delegate = self
        self.monthTextField.delegate = self
        self.yearTextField.delegate = self
    }

    // Used to restrict field to letter inputs only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == fNameTextField || textField == lNameTextField) {
            // Restrict to letters
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else {
            // Limit # of characters in certain fields
            if (textField == dayTextField || textField == monthTextField) {
                return (textField.text?.count)! < 2
            } else if (textField == heightTextField || textField == weightTextField) {
                return (textField.text?.count)! < 3
            } else if (textField == yearTextField) {
                return (textField.text?.count)! < 4
            }
            // Restrict to numbers
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
    }
    
    /**
     Verify all input fields are correctly filled
     If fields are filled out, segue to next signup page
     
     - Returns: a Bool value indicating if all the text fields have input
     */
    func verifyFields() -> Bool{
        //        Check to see if all the fields are filled out
        
        // name edge cases: empty
        // name fields are already limited to letters
        if (fNameTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your first name")
            return false
        }
        if (lNameTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your last name")
            return false
        }
        if (genderTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your gender")
            return false
        }
        if (dayTextField.text == "" || monthTextField.text == "" || yearTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter a valid date")
            return false
        }
        if (heightTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your height")
            return false
        }
        if (weightTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your weight")
            return false
        }
        return true
    }
    
    /**
     If field are inputted correctly, assign then to local variables
     */
    func assignFields() {
        // create a new user object and fill in the fields
        // push the the data object to firebase
        
    }
    
    // Mark: - UIPickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArr[row]
    }
    // End UIPickerView Functions
    
    
    // Mark: - SegmentedController Functions
    @IBAction func changeHeight(_ sender: Any) {
        if (heightController.selectedSegmentIndex == 0) {
            isCm = false
        } else {
            isCm = true
        }
    }
    
    @IBAction func changeWeight(_ sender: Any) {
        if (weightController.selectedSegmentIndex == 0) {
            isKg = false
        } else {
            isKg = true
        }
    }
    
    // End SegmentedController Functions
    
    
    
    // MARK: - Navigation
    
    // Proceeds to the last stage of signing up
    @IBAction func nextOnPress(_ sender: Any) {
        if (verifyFields()) {
            assignFields()
            self.performSegue(withIdentifier: "goToPersonalInfo", sender: self)
        } else {
            print("Failed to input correct values")
        }
    }
    // End Navigation
    
}
