//
//  ActivityViewController.swift
//  
//
//  Created by Steven Tran on 5/3/19.
//

import UIKit

class ActivityViewController: UIViewController {

    
    @IBOutlet weak var InsoleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func InsolePressed(_ sender: Any) {
        self.dismiss(animated: true) {
            print("dismissed")
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
