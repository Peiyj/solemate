//
//  SignInViewController.swift
//  Solemate
//
//  Created by Patrick on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class SignInViewController: UserFeedback{

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func SignInButton(_ sender: Any) {
        //SVProgressHUD.show()
        
        // email nil check
        if usernameTextField.text == "" {
            self.alert(Title: "sign in unsuccessful", Message: "Please enter an email")
        }
        
        // password nil check
        if passwordTextField.text == "" {
            self.alert(Title: "sign in unsuccessful", Message: "Please enter a password")
        }
        
        
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print("Log in unsuccessful: \(error!)")
                self.alert(Title: "sign in unsuccessful", Message: "Please enter a valid email and password")
            } else {
                print("Log in successful!")
                
                //SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToHome", sender: nil)
                
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
