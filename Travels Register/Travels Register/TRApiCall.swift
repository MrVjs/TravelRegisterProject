//
//  TR_APIcall.swift
//  Travels Register
//
//  Created by sunder-con870 on 04/03/22.
//

import UIKit

class TRApiCall {
    
    static func getCurrencyValue(name : String) {
        let url = "https://free.currconv.com/api/v7/convert?q=INR_\(name)&compact=ultra&apiKey=c2c7d8298efe9b56eb66"
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print(error!.localizedDescription)
                return
            }
            let val = self.convertStringToDictionary(data: data)
            TRDataTool.userDefault.setValue(val?.first?.value ?? 1, forKey: "amount")
        }.resume()
    }
    static func convertStringToDictionary(data: Data) -> [String : AnyObject]? {
            do {
                return try JSONSerialization.jsonObject(with: data , options: []) as? [String : AnyObject]
            } catch {
                print("Something went wrong")
            }
        return nil
    }
    
}
