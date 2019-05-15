//
//  HomeViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import CoreBluetooth

class HomeViewController: UIViewController {

    
    @IBOutlet weak var deviceStatusButton: UIButton!
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    var manager: CBCentralManager!
    var device: CBPeripheral?
    var characteristics: [CBCharacteristic]?
    var connected = CBPeripheralState.connected
    var disconnected = CBPeripheralState.disconnected
//    var serviceUUID = "1234"
//    var char1 = "FFE1"
//    let deviceName = "HMSoft"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    // Function used to connect / disconnect Bluetooth Device
    @IBAction func connectPressed(_ sender: Any) {
        let url = URL(string: "App-Prefs:root=Bluetooth")
        let app = UIApplication.shared
        app.openURL(url!)
        UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
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
