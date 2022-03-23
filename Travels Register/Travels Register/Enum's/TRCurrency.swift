//
//  Currency.swift
//  Travels Register
//
//  Created by sunder-con870 on 03/03/22.
//

import UIKit

enum TRCurrency : String, CaseIterable{
    static let symbol = ["₹","$","€","¥"]
    static let shortNames = ["INR","USD","EUR","JPY"]
    case Rupees = "indianrupeesign.circle"
    case Dollar = "dollarsign.circle"
    case Euro = "eurosign.circle"
    case Yen = "yensign.circle"
}
