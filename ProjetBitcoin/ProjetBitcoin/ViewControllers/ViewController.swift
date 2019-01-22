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
    
    var currency: [String] = []
    var selectedDate1 = Date()
    var selectedDate2 = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCall.GetCurrencyCurrency {[weak self](response) in
            switch response{
            case .success(let data):
                do{
                    print("switch")
                    let decoder = JSONDecoder()
                    print("switch")
                    let result = try decoder.decode([CurrencyModel].self, from : data)
                    //print(currency[1].currency)
                    for value in result{
                        if let currency = value.currency {
                            self?.currency.append(currency)
                        }
                        print(self?.currency)
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
    

        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChangedDatePicker1(_ sender: Any) {
        datePicker1.datePickerMode = UIDatePickerMode.date
        selectedDate1=datePicker1.date
        print(selectedDate1)
        
    }
    
    @IBAction func valueChangedDatePicker2(_ sender: Any) {
        datePicker2.datePickerMode = UIDatePickerMode.date
        selectedDate2=datePicker2.date
        print(selectedDate2)
    }
    
    @IBAction func tapListButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showListe", sender: nil)
    }
    
    @IBAction func tapGraphButton(_ sender: Any) {
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
}
