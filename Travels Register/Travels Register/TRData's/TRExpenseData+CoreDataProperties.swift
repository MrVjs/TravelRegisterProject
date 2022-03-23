//
//  TRExpenseData+CoreDataProperties.swift
//  Travels Register
//
//  Created by sunder-con870 on 01/03/22.
//
//

import Foundation
import CoreData


extension TRExpenseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TRExpenseData> {
        return NSFetchRequest<TRExpenseData>(entityName: "TRExpenseData")
    }

    @NSManaged public var vehicleExpense: Int64
    @NSManaged public var activityExpense: Int64
    @NSManaged public var roomRentExpense: Int64
    @NSManaged public var foodExpense: Int64
    @NSManaged public var tripID: Int64

}

extension TRExpenseData : Identifiable {

}
