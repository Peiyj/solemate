//
//  HomeViewController.swift
//  Solemate
//
//  Created by Steven Tran on 4/18/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit
import CoreBluetooth
import Charts

class HomeViewController: UIViewController {

    
    @IBOutlet weak var deviceStatusButton: UIButton!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var barChart: BarChartView!
    
    var manager: CBCentralManager!
    var device: CBPeripheral?
    var characteristics: [CBCharacteristic]?
    var connected = CBPeripheralState.connected
    var disconnected = CBPeripheralState.disconnected
//    var serviceUUID = "1234"
//    var char1 = "FFE1"
//    let deviceName = "HMSoft"
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        barChart.noDataText = "You need to provide data for the chart."
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [30.0, 24.0, 31.0, 30.0, 29.0, 32.0, 41.0, 18.0, 22.0, 4.0, 51.0, 31.0]
        
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChart.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChart.data = chartData
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
