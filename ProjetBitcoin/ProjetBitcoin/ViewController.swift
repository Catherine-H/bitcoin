//
//  ViewController.swift
//  ProjetBitcoin
//
//  Created by étudiant on 22/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var graphButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChangedDatePicker1(_ sender: Any) {
    }
    
    @IBAction func valueChangedDatePicker2(_ sender: Any) {
    }
    
    @IBAction func tapListButton(_ sender: Any) {
    }
    
    @IBAction func tapGraphButton(_ sender: Any) {
    }
}

