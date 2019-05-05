//
//  ProfileViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {


    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var surgeryDateLabel: UILabel!
    @IBOutlet weak var rehabTimeLabel: UILabel!
    
    
    @IBOutlet weak var signOutButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let docRef = db.collection("users").document((Auth.auth().currentUser?.uid)!)
        
        //print((Auth.auth().currentUser?.uid)!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Data exists and was retrieved
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //print("Document data: \(dataDescription)")
                
                let heightFt = document["heightFt"]
                let heightIn = document["heightIn"]
                
                // Assign Fields with data
                self.firstNameLabel.text = document["firstName"] as? String
                self.lastNameLabel.text = document["lastName"] as? String
                self.dobLabel.text = document["date"] as? String
                self.genderLabel.text = document["gender"] as? String
                self.heightLabel.text = ((heightFt as? String)!) + "\'" + ((heightIn as? String)!) + "\""
                self.weightLabel.text = document["weightLb"] as? String
                self.goalLabel.text = ((document["goalBodyWeight"] as? String)!) + "%"
                self.conditionLabel.text = document["condition"] as? String
                self.surgeryDateLabel.text = document["surgeryDate"] as? String
                self.rehabTimeLabel.text = document["rehabTime"] as? String
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
            print("sign out successful")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
