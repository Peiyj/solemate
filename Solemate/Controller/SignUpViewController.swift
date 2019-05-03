//
//  SignUpViewController.swift
//  Solemate
//
//  Created by Patrick on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UserFeedback {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordLabel2: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignUpButton(_ sender: Any) {
        //SVProgressHUD.show()
        
        // If username/email is null
        if usernameTextField.text == nil {
            alert(Title: "registration unsuccessful", Message: "Please enter an email")
        }
        
        // Verify Passwords are the same
        let passwordsEqual = (passwordTextField.text == passwordTextField2.text)
        
        // Passwords not same
        if (!passwordsEqual) {
            // Push alert
            self.alert(Title: "registration unsuccessful", Message: "passwords not same")
        } else {
            // Passwords same
            
            //Set up a new user on our Firebase database
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if (error != nil) {
                    print("Registration unsuccessful")
                    self.alert(Title: "registration unsuccessful", Message: (error?.localizedDescription)!)
                } else {
                    print("Registration Successful!")
                    
                    //SVProgressHUD.dismiss()
                    
                    self.performSegue(withIdentifier: "goToAccountInfo", sender: self)
                }
            }
                /*
                // Email Verification
                let actionCodeSettings = ActionCodeSettings()
                actionCodeSettings.url = URL(string: "https://www.example.com")
                // The sign-in operation has to always be completed in the app.
                actionCodeSettings.handleCodeInApp = true
                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
            
                Auth.auth().sendSignInLink(toEmail: usernameTextField.text!,
                                           actionCodeSettings: actionCodeSettings) { error in
                
                if let error = error {
                    self.showMessagePrompt(error.localizedDescription)
                    return
                }
                // The link was successfully sent. Inform the user.
                // Save the email locally so you don't need to ask the user for it again
                // if they open the link on the same device.
                UserDefaults.standard.set(self.usernameTextField.text!, forKey: "Email")
                self.showMessagePrompt("Check your email for link")
 
                }
            */
        } // end-else
    }
    
    

    
    // MARK: - Navigation

    // Navigates user back to sign in screen
    @IBAction func signInPressed(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
    }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
