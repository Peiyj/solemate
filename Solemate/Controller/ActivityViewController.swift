//
//  ActivityViewController.swift
//  
//
//  Created by Steven Tran on 5/3/19.
//

import UIKit
import Charts

class ActivityViewController: UIViewController {

    
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var InsoleButton: UIButton!
    
    let currWeight = ["On", "Off"]
    let weightPercentage = [30, 70]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pieChart.chartDescription?.text = ""
        setPieChart(dataPoints: currWeight, values: weightPercentage)
    }
    
    // Initializes Bar Chart Values
    func setBarChart() {
        
    }
    
    
    // Initiates Pie Chart Values
    func setPieChart(dataPoints: [String], values: [Int]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = ChartDataEntry(x: Double(Int(i)), y: Double(values[i]), data: dataPoints[i] as AnyObject)
            
            dataEntries.append(dataEntry1)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Within Target Range")
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChart.data = pieChartData
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
