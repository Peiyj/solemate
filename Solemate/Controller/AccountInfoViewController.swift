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
    }

    // Used to restrict field to letter inputs only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    /**
     Verify all input fields are correctly filled
     */
    func verifyFields() {
        //        Check to see if all the fields are filled out
        //        If a field is not filled out, return an error string
        //        Check for extraneous inputs, aka numbers in the name
        //        If all fields are filled correctly, segue
        
        // name edge cases: empty, numbers,
        if (fNameTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your first name")
        }
        
        if (lNameTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your last name")
        }
        
        if (genderTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your gender")
        }
        
        if (weightTextField.text == "") {
            //alert(Title: "Error", Message: "Please enter your weight")
        }
        
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
        }
        if (heightController.selectedSegmentIndex == 1) {
            isCm = true
        }
    }
    
    @IBAction func changeWeight(_ sender: Any) {
        if (weightController.selectedSegmentIndex == 0) {
            isKg = false
        }
        if (weightController.selectedSegmentIndex == 1) {
            isKg = true
        }
    }
    
    // End SegmentedController Functions
    
    
    
    // MARK: - Navigation
    
    @IBAction func nextOnPress(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "goToPersonalInfo", sender: self)
    }
    // End Navigation
    
}
