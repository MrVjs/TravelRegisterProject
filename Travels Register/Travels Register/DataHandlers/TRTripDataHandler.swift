//
//  TripDetails.swift
//  Travels Register
//
//  Created by sunder-con870 on 28/02/22.
//

import UIKit

class TRTripDataHandler {
    //Core Data
    static var tripData = [TRTripData]()
    static func reteriveAllTrips() {
        do {
            TRTripDataHandler.tripData = try TRDataTool.context.fetch(TRTripData.fetchRequest())
        } catch {
            print("Error")
        }
    }
    func addTrip(name : String,from : Date,to : Date, locationType : Int16?, vehicle : Int16?, tripID : Int64) {
        let newTrip = TRTripData(context: TRDataTool.context)
        newTrip.tripID = tripID
        updateTrip(trip: newTrip, name: name, from: from, to: to, locationType: locationType, vehicle: vehicle)
        
    }
    static func deleteTrip(item : TRTripData) {
        TRDataTool.context.delete(item)
        do {
            try TRDataTool.context.save()
            TRTripDataHandler.reteriveAllTrips()
        } catch {
            
        }
    }
    func updateTrip(trip : TRTripData,name : String,from : Date,to : Date, locationType : Int16?, vehicle : Int16?) {
        trip.placeName = name
        trip.fromDate = from
        trip.toDate = to
        trip.locationType = locationType ?? -1
        trip.usedTransport = vehicle ?? -1
        do {
            try TRDataTool.context.save()
            TRLoginVC.tabBarVCs.travel.loadDatatoView()
            TRTripDataHandler.reteriveAllTrips()
        } catch {
            print("Error")
        }
    }
    
    static func getNoOfTrip() -> Int{
        return tripData.count
    }
    static func getLastTripLocation() -> String {
        let c = TRTripDataHandler.getNoOfTrip()
        return  c != 0 ? "\(TRTripDataHandler.tripData[c-1].getPlaceName())" : "---"
    }
}
