//
//  TypesOfTransports.swift
//  Travels Register
//
//  Created by sunder-con870 on 28/02/22.
//

import UIKit

enum TRTransportType : Int16, CaseIterable {
    case Car = 0
    case Bike = 1
    case Train = 2
    case Bus = 3
    case Flight = 4
    var description : String {
        switch self {
        case .Car: return "car"
        case .Bike: return "bicycle"
        case .Train: return "train.side.front.car"
        case .Bus: return "bus"
        case .Flight: return "airplane"
        }
    }
}
