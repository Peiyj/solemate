//
//  PersonalInfoViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PersonalInfoViewController: UserFeedback, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    //create IBOutlet objects
    @IBOutlet weak var rehabTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var surgeryTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    
    //local variable declarations
    var rehabSessions = [[String]]()
    var datePicker = UIDatePicker()
    var conditionArr = ["ACLtear", "Gary"]
    var conditionPicker = UIPickerView()
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
    var numOfSessions: Int = 0
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditionTextField.underlined()
        rehabTextField.underlined()
        surgeryTextField.underlined()
        goalTextField.underlined()
        rehabTextField.delegate = self
        goalTextField.delegate = self
        
        // Do any additional setup after loading the view.
        conditionPicker.delegate = self
        conditionPicker.dataSource = self
        conditionTextField.inputView = conditionPicker
        self.conditionTextField.delegate = self
        
        // Toolbars for condition
        let generalToolBar = UIToolbar()
        generalToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(endToolbar));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(endToolbar));
        generalToolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        conditionTextField.inputAccessoryView = generalToolBar
        
        // Date toolbar for sugery date
        showDatePicker()
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
    
    // Used to restrict field to letter inputs only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onFinishPressed(_ sender: Any) {
        if verifyFields() {
            assignFields()
            performSegue(withIdentifier: "SignUpToHome", sender: self)
        }
    }
    
    /////////function for checking the fields///////////
    func verifyFields() -> Bool{
        // Check to see if all the fields are filled out
        if (rehabTextField.text == "") || (conditionTextField.text == "")
            || (goalTextField.text == "") || (surgeryTextField.text == ""){
            // do an alert to notify the user
            alert(Title: "Error", Message: "Please fill out all fields")
            //print("Fields Not Verified")
            return false
        }
        //print("Fields Verified")
        return true
    }
    
    /**
     If field are inputted correctly, assign then to local variables
     */
    func assignFields() {
        // create a new user object and fill in the fields
        
        // Create a new document with current user's ID
        db.collection("users").document(currUID).setData([
            "firstName": currFname,
            "lastName": currLname,
            "gender": currGender,
            "heightCm": String(currCm),
            "heightFt": String(currFt),
            "heightIn": String(currIn),
            "weightKg": String(currKg),
            "weightLb": String(currLb),
            "date": currDate,
            "rehabTime" : rehabTextField.text!,
            "goalBodyWeight" : goalTextField.text!,
            "condition" : conditionTextField.text!,
            "surgeryDate" : surgeryTextField.text!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.currUID)")
            }
        }
    }
    
    
    ////////these are the functions for setting up general picker view///////////
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conditionArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return conditionArr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        conditionTextField.text = conditionArr[row]
    }
    ////////these are the functions for setting up date picker view///////////
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
        
        surgeryTextField.inputAccessoryView = toolbar
        surgeryTextField.inputView = datePicker
        
    }
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        surgeryTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Add new sessions to current View Controller
    @IBAction func addSessionPressed(_ sender: Any) {
        
        if numOfSessions > 3 {
            let alertError = UIAlertController(title: "Error", message: "Cannot add more than 4 sessions", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alertError] (_) in
                print("Added too many sessions")
            }))
            self.present(alertError, animated: true, completion: nil)
        }
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Session", message: "Add a new session", preferredStyle: .alert)
        
        //2. Add the text field.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter session time (in weeks)"
            textField.keyboardType = .decimalPad
        }
        alert.addTextField { (textField2) in
            textField2.placeholder = "Enter goal body weight %"
            textField2.keyboardType = .decimalPad
        }
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(cancel)
        // 3. Grab the value from the text field
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let textField2 = alert?.textFields![1]
            
            // Error check
            if textField?.text == "" || textField2?.text == "" {
                return
            }
            
            print("Text field: \(textField?.text)")
            print("Text field2: \(textField2?.text)")
            let sessionItem = [textField?.text, textField2?.text]
            self.rehabSessions.append(sessionItem as! [String])
            self.numOfSessions += 1
            print("rehabSessions: \(self.rehabSessions)")
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func endToolbar(){
        self.view.endEditing(true)
    }
        
    
    // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
