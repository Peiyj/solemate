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
    
    var currUID = ""
    
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
                let uid: String = Auth.auth().currentUser?.uid ?? ""
                self.currUID = uid
                
                if (error != nil) {
                    print("Registration unsuccessful")
                    self.alert(Title: "registration unsuccessful", Message: (error?.localizedDescription)!)
                } else {
                    print("Registration Successful!")
                    
                    //SVProgressHUD.dismiss()
                    
                    self.performSegue(withIdentifier: "goToAccountInfo", sender: self)
                }
            }
        } // end-else
    }

    
    // MARK: - Navigation

    // Navigates user back to sign in screen
    @IBAction func signInPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AccountInfoViewController
        vc.currUID = self.currUID
    }
    
    

}
