//
//  Data.swift
//  Travels Register
//
//  Created by sunder-con870 on 03/03/22.
//

import UIKit

class TRDataTool {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var userDefault = UserDefaults()
}
