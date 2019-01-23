//
//  ViewController.swift
//  ProjetBitcoin
//
//  Created by étudiant on 22/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var startSearch: UIButton!
    
    var currency: [String] = []
    var priceModels: [PriceModel] = []
    var selectedDate1 = Date()
    var selectedDate2 = Date()
    var dateString1: String = "2018-12-12"
    var dateString2: String = "2019-01-21"
    var money : String = "AED"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        listButton.alpha = 0
        graphButton.alpha = 0
        
        ApiCall.GetCurrencyCurrency {[weak self](response) in
            switch response{
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([CurrencyModel].self, from : data)
                    //print(currency[1].currency)
                    for value in result{
                        if let currency = value.currency {
                            self?.currency.append(currency)
                        }
                       // print(self?.currency)
                    }
                    self?.pickerView.reloadAllComponents()
                }catch (let error){
                   print(error.localizedDescription)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChangedDatePicker1(_ sender: Any) {
        datePicker1.datePickerMode = UIDatePickerMode.date
        selectedDate1 = datePicker1.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString1 = formatter.string(from: selectedDate1)
        
        print("début" , dateString1)
    }
    
    @IBAction func valueChangedDatePicker2(_ sender: Any) {
        datePicker2.datePickerMode = UIDatePickerMode.date
        selectedDate2=datePicker2.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString2 = formatter.string(from: selectedDate2)
        print("fin" , dateString2)
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
                }
                
                break
            case "showChart":
                if let destinationDetailVC = segue.destination as?
                    ListeViewController {
                    destinationDetailVC.priceModels = priceModels
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
                            //On a des price models de parsés, on peut continuer
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
        print(money)
    }
}
