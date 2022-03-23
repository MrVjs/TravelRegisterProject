//
//  TRActivityData+CoreDataProperties.swift
//  Travels Register
//
//  Created by sunder-con870 on 01/03/22.
//
//

import Foundation
import CoreData


extension TRActivityData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TRActivityData> {
        return NSFetchRequest<TRActivityData>(entityName: "TRActivityData")
    }

    @NSManaged public var activityName: String?
    @NSManaged public var dateNtime: Date?
    @NSManaged public var duration: Double
    @NSManaged public var cost: Int64
    @NSManaged public var tripID: Int64

}

extension TRActivityData : Identifiable {

}
