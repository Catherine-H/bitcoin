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
    weak var axisFormat: IAxisValueFormatter?
    var dateFormater: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormat = self
        self.title = "Cours du Bitcoin"
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateGraph() {
        priceModels.sort { (priceModel1, priceModel2) -> Bool in
            if let date1 = priceModel1.currentDate, let date2 = priceModel2.currentDate {
                return date1 < date2
            }
            return false
        }
        
        for priceModel in priceModels {
            if let date = priceModel.currentDate {
                let doubleDate = date.timeIntervalSince1970
                let value = ChartDataEntry(x: doubleDate, y: priceModel.price! )
                lineChartEntry.append(value)

                chtChart.rightAxis.enabled = false
                chtChart.xAxis.labelPosition = .bottom
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: date)
                print(dateString)
                dateFormater.append(dateString)
            }
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Valeur du Bitcoin")
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)
        chtChart.data = data
        chtChart.xAxis.valueFormatter = axisFormat
        chtChart.xAxis.labelRotationAngle = -45.0
        line1.drawFilledEnabled = true
        line1.fillColor = .red
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        
    }
    
    func getDateFormater(index: Int) -> Int {
        return (index % dateFormater.count)
    }
}

extension ChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormaterIndex:Int = self.getDateFormater(index: Int(value) + 0)
        return dateFormater[dateFormaterIndex]
    }
}
