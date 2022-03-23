//
//  LoginData+CoreDataProperties.swift
//  Travels Register
//
//  Created by sunder-con870 on 02/03/22.
//
//

import Foundation
import CoreData


extension LoginData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginData> {
        return NSFetchRequest<LoginData>(entityName: "LoginData")
    }

    @NSManaged public var isLoggedIn: Bool

}

extension LoginData : Identifiable {

}
