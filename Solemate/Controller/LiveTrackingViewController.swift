//
//  LiveTrackingViewController.swift
//  Solemate
//
//  Created by Steven Tran on 5/4/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import CoreBluetooth

class LiveTrackingViewController: UserFeedback {
    // This class deals with pulling all bluetooth data

    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var seconds = 30
    var isTimerRuning = false
    
    var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize Bluetooth Configuration Manager
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager.scanForPeripherals(withServices: nil)

        // Begin the Timer
        runTimer()
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            
            // timer finish
            self.performSegue(withIdentifier: "showResults", sender: self)
            // alert(Title: "Time's Up!", Message: "Good job tracking.")
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

extension LiveTrackingViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
        }
    }
    
    
}
