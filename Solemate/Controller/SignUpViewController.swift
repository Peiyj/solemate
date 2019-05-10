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
import SVProgressHUD

class SignUpViewController: UserFeedback, UITextFieldDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordLabel2: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    
    var currUID = ""
    let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
    let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextField2.delegate = self
        usernameTextField.underlined()
        passwordTextField.underlined()
        passwordTextField2.underlined()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // The following functions deal with readjusting the UIView when the keyboard appears
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= (keyboardFrame.height - screenHeight/4)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func SignUpButton(_ sender: Any) {
        // If username/email is null
        if usernameTextField.text == nil {
            alert(Title: "registration unsuccessful", Message: "Please enter an email")
        }
        
        // Verify Passwords are the same
        let passwordsEqual = (passwordTextField.text == passwordTextField2.text)
        
        // Passwords not same
        if (!passwordsEqual) {
            self.alert(Title: "registration unsuccessful", Message: "passwords not same")
        } else {
            // Passwords same
            SVProgressHUD.show()
            
            //Set up a new user on our Firebase database
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                let uid: String = Auth.auth().currentUser?.uid ?? ""
                self.currUID = uid
                
                if (error != nil) {
                    SVProgressHUD.dismiss()
                    self.alert(Title: "registration unsuccessful", Message: (error?.localizedDescription)!)
                } else {
                    SVProgressHUD.dismiss()
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
