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
    var dateDebut: String = ""
    var dateFin: String = ""
    var money: String = ""
    var line = LineChartDataSet(values: [], label: "")
    var lineChartEntry = [ChartDataEntry]()
    weak var axisFormat: IAxisValueFormatter?
    var dateFormater: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cours du Bitcoin en " + money
        
        axisFormat = self
        
        updateGraph()
        customGraph()
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
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: date)
                dateFormater.append(dateString)
            }
        }
        
        line = LineChartDataSet(values: lineChartEntry, label: "Valeur du Bitcoin")
        let data = LineChartData()
        data.addDataSet(line)
        chtChart.data = data
    }
    
    func getDateFormater(index: Int) -> Int {
        return (index % dateFormater.count)
    }
    
    func customGraph() {
        chtChart.rightAxis.enabled = false
        chtChart.xAxis.labelPosition = .bottom
        chtChart.xAxis.valueFormatter = axisFormat
        chtChart.xAxis.labelRotationAngle = -45.0
        line.drawFilledEnabled = true
        line.fillColor = .red
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        line.colors = [NSUIColor.blue]
    }
}

extension ChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormaterIndex:Int = self.getDateFormater(index: Int(value) + 0)
        return dateFormater[dateFormaterIndex]
    }
}
