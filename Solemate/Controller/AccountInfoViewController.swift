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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightController: UISegmentedControl!
    @IBOutlet weak var weightController: UISegmentedControl!
    
    // local Variable Declarations
    var genderArr = ["Male", "Female"]
    var ftArr = Array(2...8)
    var inArr = Array(0...11)
    var cmArr = Array(0...250)
    var lbArr = Array(0...500)
    var kgArr = Array(0...200)
    var genderPicker = UIPickerView()
    var datePicker = UIDatePicker()
    var heightPicker = UIPickerView()
    var weightPicker = UIPickerView()
    var isKg = false
    var isCm = false
    var currFt = 0
    var currIn = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        heightPicker.delegate = self
        heightPicker.dataSource = self
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        genderTextField.inputView = genderPicker
        heightTextField.inputView = heightPicker
        weightTextField.inputView = weightPicker
        
        genderPicker.tag = 0
        heightPicker.tag = 1
        weightPicker.tag = 2
        
        self.fNameTextField.delegate = self
        self.lNameTextField.delegate = self
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self
        
        // Toolbars for Gender, Height, Weight
        let generalToolBar = UIToolbar()
        generalToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: self.view.endEditing(true));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: self.view.endEditing(true));
        
        generalToolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        showDatePicker()
    }
    
    /**
      Date Picker
     */
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
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
            if (textField == heightTextField || textField == weightTextField) {
                return (textField.text?.count)! < 3
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
        if (dateTextField.text == "") {
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
    
    // Mark: - UIPicker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 1 && isCm == false {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return genderArr.count
        } else if pickerView.tag == 1 && isCm == true {
            return cmArr.count
        } else if pickerView.tag == 1 && isCm == false {
            if component == 0 {
                return ftArr.count
            } else {
                return inArr.count
            }
        } else if pickerView.tag == 2 && isKg == true {
            return kgArr.count
        } else {
            return lbArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            genderTextField.text = genderArr[row]
        } else if pickerView.tag == 1 && isCm == false {
            //heightTextField.text = "yes"
            if component == 0 { // Feet
                currFt = ftArr[row]
            } else if component == 1 {
                currIn = inArr[row]
            }
            heightTextField.text = "\(currFt)\' \(currIn)\""
        } else if pickerView.tag == 1 && isCm == true {
            heightTextField.text = String(cmArr[row])
        } else if pickerView.tag == 2 && isKg == false {
            weightTextField.text = String(lbArr[row])
        } else {
            weightTextField.text = String(kgArr[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return genderArr[row]
        } else if pickerView.tag == 1 && isCm == false {
            if component == 0 {
                return String(ftArr[row])
            } else if component == 1 {
                return String(inArr[row])
            }
        } else if pickerView.tag == 1 && isCm == true {
            return String(cmArr[row])
        } else if pickerView.tag == 2 && isKg == false {
            return String(lbArr[row])
        } else {
            return String(kgArr[row])
        }
        return "hello"
    }
    // End UIPickerView Functions
    
    
    // Mark: - SegmentedController Functions
    @IBAction func changeHeight(_ sender: Any) {
        // TODO: - change the weight value within the text field if there already exists input in it
        if (heightController.selectedSegmentIndex == 0) {
            isCm = false
        } else {
            isCm = true
        }
    }
    
    @IBAction func changeWeight(_ sender: Any) {
        // TODO: - change the weight value within the text field if there already exists input in it
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
