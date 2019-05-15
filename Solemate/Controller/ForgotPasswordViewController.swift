//
//  ForgotPasswordViewController.swift
//  Solemate
//
//  Created by Steven Tran on 5/9/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ForgotPasswordViewController: UserFeedback, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.underlined()
        emailTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func onSubmitPressed(_ sender: Any) {
        SVProgressHUD.show()
        if emailTextField.text == "" {
            self.alert(Title: "Error", Message: "Please enter an email")
        }
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            
            if error != nil {
                SVProgressHUD.dismiss()
                self.alert(Title: "Error", Message: (error?.localizedDescription)!)
            } else {
                SVProgressHUD.dismiss()
                print("successfully emailed")
                self.performSegue(withIdentifier: "backToRoot", sender: self)
            }
        }
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
