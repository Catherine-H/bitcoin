//
//  ChartViewController.swift
//  ProjetBitcoin
//
//  Created by étudiant on 23/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    @IBOutlet weak var chtChart: LineChartView!
    var priceModels: [PriceModel] = []
    var lineChartEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraph() {
        //priceModels.sort { $0.currentDate! > $1.currentDate! }
        var dateFormater: [String] = []
        for priceModel in priceModels {
            if let date = priceModel.currentDate {
                let doubleDate = date.timeIntervalSince1970
                let value = ChartDataEntry(x: doubleDate, y: priceModel.price! )
                lineChartEntry.append(value)
                let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
                line1.colors = [NSUIColor.blue]
                let data = LineChartData()
                data.addDataSet(line1)
                chtChart.data = data
                chtChart.rightAxis.enabled = false
                chtChart.xAxis.labelPosition = .bottom
                //let date = NSDate(timeIntervalSince1970: <#T##TimeInterval#>)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: date)
                print(dateString)
                dateFormater.append(dateString)
                
                
            }
        }
        chtChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateFormater)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
