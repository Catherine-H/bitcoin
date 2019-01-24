//
//  DetailTableViewCell.swift
//  ProjetBitcoin
//
//  Created by étudiant on 23/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var labeldate: UILabel!
    @IBOutlet weak var labelPrix: UILabel!
    
    func fill(withPriceModel pricemodel: PriceModel) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let curDate = formatter.string(from: pricemodel.currentDate!)
        let price: String = String(format: "%.2f", pricemodel.price!)
        labeldate.text = curDate
        labelPrix.text = price
    }
}
