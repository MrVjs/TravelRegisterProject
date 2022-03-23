//
//  TRTrip+CoreDataProperties.swift
//  Travels Register
//
//  Created by sunder-con870 on 01/03/22.
//
//

import Foundation
import CoreData


extension TRTripData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TRTripData> {
        return NSFetchRequest<TRTripData>(entityName: "TRTripData")
    }

    @NSManaged public var placeName: String?
    @NSManaged public var fromDate: Date?
    @NSManaged public var toDate: Date?
    @NSManaged public var locationType: Int16
    @NSManaged public var usedTransport: Int16
    @NSManaged public var tripID: Int64

}

extension TRTripData : Identifiable {
    func getVehicleType() -> String {
        switch usedTransport {
        case 0:
            return TRTransportType(rawValue: 0)!.description
        case 1:
            return TRTransportType(rawValue: 1)!.description
        case 2:
            return TRTransportType(rawValue: 2)!.description
        case 3:
            return TRTransportType(rawValue: 3)!.description
        case 4:
            return TRTransportType(rawValue: 4)!.description
        default:
            return TRTransportType(rawValue: 0)!.description
        }
    }
    func getPlaceName() -> String {
        guard let name = placeName else {
            return "Some Where"
        }
        return name.count > 0 ? name : "Some Where"
    }
    func getNoOfDays() -> String {
        return String(Int(fromDate!.distance(to: toDate!)/86400 + 1))
    }
    func getStartDate() -> String {
        let date = fromDate!.formatted(date: .numeric, time: .omitted)
        return date
    }
}
