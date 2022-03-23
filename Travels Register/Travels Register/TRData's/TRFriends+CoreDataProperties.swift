//
//  TRFriends+CoreDataProperties.swift
//  Travels Register
//
//  Created by sunder-con870 on 01/03/22.
//
//

import Foundation
import CoreData


extension TRFriendsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TRFriendsData> {
        return NSFetchRequest<TRFriendsData>(entityName: "TRFriendsData")
    }

    @NSManaged public var friendName: String?
    @NSManaged public var occupation: String?
    @NSManaged public var meetPlace: String?
    @NSManaged public var phoneNo: String?
    @NSManaged public var tripID: Int64

}

extension TRFriendsData : Identifiable {
    
}
