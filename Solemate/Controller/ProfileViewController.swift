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

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var surgeryDateLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var window: UIWindow?
    var rehabSessions = [[String]]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Displaying user information
        let docRef = db.collection("users").document((Auth.auth().currentUser?.uid)!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Data exists and was retrieved
                let heightFt = document["heightFt"]
                let heightIn = document["heightIn"]
                
                // Assign Fields with data
                self.firstNameLabel.text = document["firstName"] as? String
                self.lastNameLabel.text = document["lastName"] as? String
                self.dobLabel.text = document["date"] as? String
                self.genderLabel.text = document["gender"] as? String
                self.heightLabel.text = ((heightFt as? String)!) + "\'" + ((heightIn as? String)!) + "\""
                self.weightLabel.text = document["weightLb"] as? String
                self.conditionLabel.text = document["condition"] as? String
                self.surgeryDateLabel.text = document["surgeryDate"] as? String
                self.nameLabel.text = (self.firstNameLabel.text!) + "!"
                // Populating RehabSessions Array
                if let session1 = document["session1"] as? [String] {
                    self.rehabSessions.append(document["session1"] as! [String])
                    self.tableView.reloadData()
                }
                if let session2 = document["session2"] as? [String] {
                    self.rehabSessions.append(document["session2"] as! [String])
                    self.tableView.reloadData()
                }
                if let session3 = document["session3"] as? [String] {
                    self.rehabSessions.append(document["session3"] as! [String])
                    self.tableView.reloadData()
                }
                if let session4 = document["session4"] as? [String] {
                    self.rehabSessions.append(document["session4"] as! [String])
                    self.tableView.reloadData()
                }
            } else {
                print("Document does not exist")
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    } // end viewDidLoad
    
    /* TABLEVIEW CODE */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rehabSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell") as! SessionCell
        let session = rehabSessions[indexPath.row]
        let weight = session[1] + " % Body Weight"
        let weeks = session[0] + " Weeks"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
        cell.weekLabel!.text = weeks
        cell.weightLabel!.text = weight
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    /* END TABLEVIEW CODE */
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController = main.instantiateViewController(withIdentifier: "SignInViewController")
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            
            delegate.window?.rootViewController = signInViewController
            
            //print("sign out successful")
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
