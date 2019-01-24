//
//  ViewController.swift
//  ProjetBitcoin
//
//  Created by étudiant on 22/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    var currencyPickerView: UIPickerView = UIPickerView()
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var startSearch: UIButton!
    @IBOutlet weak var dateDebut: UITextField!
    @IBOutlet weak var dateFin: UITextField!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelMoney: UILabel!
    @IBOutlet weak var textFieldMoney: UITextField!
    
    var currency: [String] = []
    var priceModels: [PriceModel] = []
   // var selectedDate1 = Date()
    var selectedDate2 = Date()
    var dateString1: String = ""
    var dateString2: String = ""
    var money : String = ""
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Selection des informations"
        
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
        textFieldMoney.inputView = currencyPickerView
        
       dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dateFin.alpha = 0
        labelEndDate.alpha = 0
        labelMoney.alpha = 0
        textFieldMoney.alpha = 0
     
        customButton(myButton: startSearch)
        customButton(myButton: listButton)
        customButton(myButton: graphButton)
        
        recupererCurrency()
    }

    func recupererCurrency() {
        ApiCall.GetCurrencyCurrency {[weak self](response) in
            switch response{
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([CurrencyModel].self, from : data)
                    for value in result{
                        if let currency = value.currency {
                            self?.currency.append(currency)
                        }
                    }
                    self?.currencyPickerView.reloadAllComponents()
                }catch (let error){
                    print(error.localizedDescription)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func tapDown(_ sender: UITextField) {
        let datePickerView1: UIDatePicker = UIDatePicker()
        datePickerView1.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView1
        
        if dateString2=="" {
            dateString1 = dateFormatter.string(from: currentDate)
            dateDebut.text = dateString1
        }
        
        dateFin.alpha = 1
        labelEndDate.alpha = 1
        
        datePickerView1.addTarget(self, action: #selector(handleDatePicker1(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker1(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString1 = dateFormatter.string(from: sender.date)
        dateDebut.text = dateString1
    }

    @IBAction func tapDown2(_ sender: UITextField) {
        let datePickerView2: UIDatePicker = UIDatePicker()
        datePickerView2.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView2
        
        if dateString2=="" {
            dateString2 = dateFormatter.string(from: currentDate)
            dateFin.text = dateString2
        }
        
        datePickerView2.addTarget(self, action: #selector(handleDatePicker2(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker2(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString2 = dateFormatter.string(from: sender.date)
        dateFin.text = dateString2
        labelMoney.alpha = 1
        textFieldMoney.alpha = 1
    }
 
    
    @IBAction func tapDownMoney(_ sender: UITextField) {
        money = currency[0]
        textFieldMoney.text = money
    }
    
    @IBAction func tapListButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showListe", sender: priceModels)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showListe":
                if let destinationDetailVC = segue.destination as?
                    ListeViewController {
                    destinationDetailVC.priceModels = priceModels
                    destinationDetailVC.money = money
                }
                break
            case "showChart":
                if let destinationDetailVC = segue.destination as?
                    ChartViewController {
                    destinationDetailVC.priceModels = priceModels
                    destinationDetailVC.money = money
                }
                break
            default:
                break
            }
        }
    }
    
    @IBAction func tapGraphButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showChart", sender: priceModels)
    }

    @IBAction func tapStartSearch(_ sender: Any) {
        let parameters = ["start": dateString1, "end": dateString2, "currency": money]
        
        ApiCall.getListByDateAndMoney(param: parameters) {[weak self] (result) in
            switch result {
            case .success(let dataAsJson):
                self?.view.endEditing(true)
                self?.listButton.alpha = 1
                self?.graphButton.alpha = 1
                //cast en dictionnaire
                if let dataAsDictionary = dataAsJson as? [String:Any] {
                    if let dataBPI = dataAsDictionary["bpi"] as? [String:Any] {
                        //Cast les clés du dictionnaire en array de string
                        let lazyMap = dataBPI.keys
                        let allKeysFromDict: [String] = Array(lazyMap)
                        var arrayOfPriceModels : [PriceModel] = []
                        for key in allKeysFromDict {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            if let date = dateFormatter.date(from: key) {
                                if let price = dataBPI[key] as? Double {
                                    let priceModel: PriceModel = PriceModel(date: date, price: price)
                                    arrayOfPriceModels.append(priceModel)
                                    
                                }
                            }
                        }
                        if arrayOfPriceModels.count > 0 {
                            //On a des prices models de parsés, on peut continuer
                            self?.priceModels = arrayOfPriceModels
                        }
                    }
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func customButton(myButton: UIButton) {
        myButton.backgroundColor = .clear
        myButton.layer.cornerRadius = 5
        myButton.layer.borderWidth = 1
        myButton.layer.borderColor = UIColor.gray.cgColor
        myButton.backgroundColor = UIColor.gray
        myButton.tintColor = UIColor.white
        myButton.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ViewController: UIPickerViewDelegate {
    
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        money = currency[row]
        textFieldMoney.text = money
        startSearch.alpha = 1
        print(money)
    }

}
