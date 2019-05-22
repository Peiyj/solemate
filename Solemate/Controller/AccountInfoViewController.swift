//
//  AccountInfoViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AccountInfoViewController: UserFeedback, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

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
    var ftArr = Array(3...7)
    var inArr = Array(0...11)
    var cmArr = Array(90...200)
    var lbArr = Array(70...300)
    var kgArr = Array(30...150)
    var genderPicker = UIPickerView()
    var datePicker = UIDatePicker()
    var heightPicker = UIPickerView()
    var weightPicker = UIPickerView()
    var isKg = false
    var isCm = false
    var currFt = 0
    var currIn = 0
    var currCm = 0
    var currKg = 0
    var currLb = 0
    var currGender = ""
    var currFname = ""
    var currLname = ""
    var currDate = ""
    var currUID = ""
    let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
    let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fNameTextField.underlined()
        lNameTextField.underlined()
        genderTextField.underlined()
        dateTextField.underlined()
        heightTextField.underlined()
        weightTextField.underlined()
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        heightPicker.delegate = self
        heightPicker.dataSource = self
        weightPicker.delegate = self
        weightPicker.dataSource = self
        self.fNameTextField.delegate = self
        self.lNameTextField.delegate = self
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self
        
        genderTextField.inputView = genderPicker
        heightTextField.inputView = heightPicker
        weightTextField.inputView = weightPicker
        heightPicker.selectRow(3, inComponent: 0, animated: true)
        weightPicker.selectRow(3, inComponent: 0, animated: true)
        genderPicker.selectRow(3, inComponent: 0, animated: true)
        
        genderPicker.tag = 0
        heightPicker.tag = 1
        weightPicker.tag = 2
        
        // Toolbars for Gender, Height, Weight
        let generalToolBar = UIToolbar()
        generalToolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(endToolbar));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(endToolbar));
        
        generalToolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        genderTextField.inputAccessoryView = generalToolBar
        heightTextField.inputAccessoryView = generalToolBar
        weightTextField.inputAccessoryView = generalToolBar
        
        showDatePicker()
    }
    
    // Exits keyboard view when touching anywhere else on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
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
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
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
    
    @objc func endToolbar(){
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
        // Check to see if all the fields are filled out
        if (fNameTextField.text == "") || (lNameTextField.text == "") || (genderTextField.text == "") || (dateTextField.text == "") || (heightTextField.text == "") || (weightTextField.text == "") {
            alert(Title: "Error", Message: "Please fill out all the fields")
            return false
        }
        return true
    }
    
    /**
     If field are inputted correctly, assign then to local variables
     */
    func assignFields() {
        currFname = fNameTextField.text!
        currLname = lNameTextField.text!
        currDate = dateTextField.text!
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
            currGender = genderArr[row]
            genderTextField.text = genderArr[row]
        } else if pickerView.tag == 1 && isCm == false {
            //heightTextField.text = "yes"
            if component == 0 { // Feet
                currFt = ftArr[row]
            } else if component == 1 {
                currIn = inArr[row]
            }
            currCm = Int((Double(currFt) * 30.5) + (Double(currIn) * 2.55))
            heightTextField.text = "\(currFt)\' \(currIn)\""
        } else if pickerView.tag == 1 && isCm == true {
            currCm = cmArr[row]
            currFt = Int(Double(currCm) * 0.033)
            currIn = Int(((Double(currCm) * 0.033) - Double(currFt)) * 12)
            heightTextField.text = String(cmArr[row])
        } else if pickerView.tag == 2 && isKg == false {
            currLb = lbArr[row]
            currKg = Int(Double(currLb) * 0.453592)
            weightTextField.text = String(lbArr[row])
        } else {
            currKg = kgArr[row]
            currLb = Int(Double(currKg) *
                2.20462)
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
    
    
    // Mark: - SegmentedController Functions //
    
    @IBAction func changeHeight(_ sender: Any) {
        // TODO: - change the weight value within the text field if there already exists input in it
        if (heightController.selectedSegmentIndex == 0) {
            // lb is pressed
            isCm = false
            if heightTextField.text != "" {
                heightTextField.text = "\(currFt)\' \(currIn)\""
            }
        } else {
            // cm is pressed
            isCm = true
            if heightTextField.text != "" {
                heightTextField.text = "\(currCm)"
            }
        }
    }
    
    @IBAction func changeWeight(_ sender: Any) {
        if (weightController.selectedSegmentIndex == 0) {
            // lb is pressed
            isKg = false
            if weightTextField.text != "" {
                //currLb = Int(Double(currKg) * 0.453592)
                weightTextField.text =  String(currLb)
            }
        } else {
            // kg is pressed
            isKg = true
            if weightTextField.text != "" {
                //currKg = Int(Double(currLb) * 2.20462)
                weightTextField.text =  String(currKg)
            }
        }
    }
    
    // End SegmentedController Functions
    
    
    
    // MARK: - Navigation //
    
    // Proceeds to the last stage of signing up
    @IBAction func nextOnPress(_ sender: Any) {
        if (verifyFields()) {
            assignFields()
            self.performSegue(withIdentifier: "goToPersonalInfo", sender: self)
        } else {
            print("Failed to input correct values")
        }
    }
    
    // Doesn't currently do anything
    @IBAction func onBackPressed(_ sender: Any) {
 
    }
    
    // Deletes user from Firebase if they navigate back to sign in page
    @IBAction func signInPressed(_ sender: Any) {
        let user = Auth.auth().currentUser
        //print(user)
        user?.delete { error in
            if let error = error {
                // An error happened.
                print(error)
            } else {
                // Account deleted.
                print("successfully deleted account")
            }
        }
    }
    
    // Used for going into the next sign up page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPersonalInfo" {
            let vc = segue.destination as! PersonalInfoViewController
            vc.currFt = self.currFt
            vc.currIn = self.currIn
            vc.currCm = self.currCm
            vc.currKg = self.currKg
            vc.currLb = self.currLb
            vc.currGender = self.currGender
            vc.currFname = self.currFname
            vc.currLname = self.currLname
            vc.currDate = self.currDate
            vc.currUID = self.currUID
        }
    }
    // End Navigation
    
}
