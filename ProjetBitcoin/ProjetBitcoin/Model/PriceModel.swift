//
//  PriceModel.swift
//  ProjetBitcoin
//
//  Created by Justine Sgherzi on 23/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import Foundation

class PriceModel: Codable{
    let currentDate : Date?
    let price: Double?
    
    required init(date: Date, price: Double) {
        self.currentDate = date
        self.price = price
    }
    //required init(date: Date, price: Double) {
        //Initialiser les variables locales
    //}
}
