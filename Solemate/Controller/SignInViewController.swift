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
import SVProgressHUD

class SignInViewController: UserFeedback, UITextFieldDelegate{
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var activeTextField: UITextField!
    let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
    let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.underlined()
        passwordTextField.underlined()
        
        // Do any additional setup after loading the view.
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // The following functions deal with readjusting the UIView when the keyboard appears
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
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
    
    @IBAction func SignInButton(_ sender: Any) {
        // email nil check
        if usernameTextField.text == "" {
            self.alert(Title: "sign in unsuccessful", Message: "Please enter an email")
        }
        // password nil check
        if passwordTextField.text == "" {
            self.alert(Title: "sign in unsuccessful", Message: "Please enter a password")
        }
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                //print("Log in unsuccessful: \(error!)")
                SVProgressHUD.dismiss()
                self.alert(Title: "sign in unsuccessful", Message: "Please enter a valid email and password")
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToHome", sender: nil)
            }
        }
    }
    
    // used for logging out later in the app
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
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
