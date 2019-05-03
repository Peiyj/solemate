//
//  PersonalInfoViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    //create IBOutlet objects
    @IBOutlet weak var rehabTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var surgeryTextField: UITextField!
    
    //local variable declarations
    var datePicker = UIDatePicker()
    var conditionArr = ["ACLtear", "Gary"]
    var conditionPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

    @IBAction func onPress(_ sender: Any) {
        if (verifyFields()) {
            assignFields()
            self.performSegue(withIdentifier: "goToHome", sender: self)
        } else {
            print("Failed to input correct values")
        }
    }
    
    /////////function for checking the fields///////////
    func verifyFields() -> Bool{
        // Check to see if all the fields are filled out
        if (rehabTextField.text == "") || (conditionTextField.text == "")
            || (goalTextField.text == "") || (surgeryTextField.text == ""){
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
    
    @objc func endToolbar(){
        self.view.endEditing(true)

    
    // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
