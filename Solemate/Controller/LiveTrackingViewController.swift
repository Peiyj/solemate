//
//  LiveTrackingViewController.swift
//  Solemate
//
//  Created by Steven Tran on 5/4/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class LiveTrackingViewController: UserFeedback {
    // This class deals with pulling all bluetooth data

    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var seconds = 30
    var isTimerRuning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        runTimer()
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            // send alert to indicate time's up
            alert(Title: "Time's Up!", Message: "Good job tracking.")
        } else {
            seconds -= 1
            self.timerLabel.text = "\(seconds)"
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(LiveTrackingViewController.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerRuning = true
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        timer.invalidate()
        seconds = 30
        self.timerLabel.text = "\(seconds)"
        runTimer()
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
