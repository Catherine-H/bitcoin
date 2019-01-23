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
            }
        }
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
