//
//  StartOneViewController.swift
//  Solemate
//
//  Created by Steven Tran on 5/4/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class StartOneViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func onHomePress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func onBackPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
