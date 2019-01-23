//
//  ApiCall.swift
//  ProjetBitcoin
//
//  Created by Justine Sgherzi on 22/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import Foundation
import Alamofire

class ApiCall {
    static func GetCurrencyCurrency(withCompletion completion:@escaping (Result<Data>) -> Void){
        Alamofire.request("https://api.coindesk.com/v1/bpi/supported-currencies.json").responseData { (response) in
            completion(response.result)
        }
    }
    
    static func getListByDateAndMoney(param: [String:String], withCompletion completion:@escaping (Result<Any>) -> Void){
        Alamofire.request("https://api.coindesk.com/v1/bpi/historical/close.json", method: .get, parameters: param).responseJSON { (responseData) in
            print("responseData" , responseData)
            completion(responseData.result)
        }
    }
    
    
}


