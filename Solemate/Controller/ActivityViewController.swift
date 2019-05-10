//
//  ActivityViewController.swift
//  
//
//  Created by Steven Tran on 5/3/19.
//

import UIKit
import Charts

class ActivityViewController: UIViewController {

    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var InsoleButton: UIButton!
    
    let currWeight = ["On", "Off"]
    let weightPercentage = [30, 70]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartValues()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateGraph(_ sender: Any) {
        let count = Int(arc4random_uniform(20)+3)
        setChartValues(count)
    }
    
    @IBAction func InsolePressed(_ sender: Any) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    
    //this function will set the values of the chart
    func setChartValues(_ count: Int  = 20){
        let values = (0..<count).map {(i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count)) + 3)
            return ChartDataEntry(x: Double(i), y : val)
        }
        let set1 = LineChartDataSet(values: values, label: "test 1")
        let data = LineChartData(dataSet: set1)
        
        self.lineChartView.data = data
    }

}
