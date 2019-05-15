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

class HomeViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

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

        // Bluetooth manager setup
        // create concurrent background queue for central
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
        
        // manage, and collect data from peripherals
        manager = CBCentralManager(delegate: self, queue: centralQueue)
        
        // Chart Set up
        barChart.noDataText = "You need to provide data for the chart."
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let label = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0]
        let unitsSold = [30.0, 24.0, 31.0, 30.0, 29.0, 32.0, 31.0]
        
        setChart(dataPoints: unitsSold, values: label)
    }

    /* CHART FUNCTIONALITY */
    func setChart(dataPoints: [Double], values: [Double]) {
        barChart.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "% Weight applied to injured foot")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.xAxis.labelPosition = .bottom
        barChart.data = chartData
        barChart.animate(xAxisDuration: 2.0)
        barChart.animate(yAxisDuration: 2.0)
        
        let limline = ChartLimitLine(limit: 30.0, label: "Target % Weight")
        barChart.rightAxis.addLimitLine(limline)
    }
    /* END CHART FUNCTIONALITY */

    
    /* CORE-BLUETOOTH FUNCTIONALITY */
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // State management for Central
        switch central.state {
            
            case .unknown:
                print("Bluetooth status is UNKNOWN")
            case .resetting:
                print("Bluetooth status is RESETTING")
            case .unsupported:
                print("Bluetooth status is UNSUPPORTED")
            case .unauthorized:
                print("Bluetooth status is UNAUTHORIZED")
            case .poweredOff:
                print("Bluetooth status is POWERED OFF")
            case .poweredOn:
                print("Bluetooth status is POWERED ON")
        } // end switch statement
    }
    
    // Function used to connect / disconnect Bluetooth Device
    @IBAction func connectPressed(_ sender: Any) {
        let url = URL(string: "App-Prefs:root=Bluetooth")
        let app = UIApplication.shared
        app.openURL(url!)
        UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
    }
    /* END CORE-BLUETOOTH FUNCTIONALITY */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
