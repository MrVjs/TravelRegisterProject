//
//  RestoreData.swift
//  Travels Register
//
//  Created by sunder-con870 on 22/03/22.
//

import UIKit

class RestoreData {
    //Variables
    ///Datas
    private var trip : [TRTripData]!
    private var expense : TRExpenseData!
    private var friend : TRFriendsData!
    private var activity : TRActivityData!
    //Functions
    ///Static Functions
    static func deleteData() {
        while TRTripDataHandler.tripData.isEmpty != true {
            TRTripDataHandler.deleteTrip(item: TRTripDataHandler.tripData.first!)
        }
        while TRActivityDataHandler.activityData.isEmpty != true {
            TRActivityDataHandler.deleteActivity(item: TRActivityDataHandler.activityData.first!)
        }
        while TRExpenseDataHandler.expenseData.isEmpty != true {
            TRExpenseDataHandler.deleteExpense(item: TRExpenseDataHandler.expenseData.first!)
        }
        while TRFriendDataHandeler.friendData.isEmpty != true {
            TRFriendDataHandeler.deleteFriend(item: TRFriendDataHandeler.friendData.first!)
        }
    }
    static func restoreData() {
        let placeName = ["Goa","Chennai","Ooty","Kodaikanal","Delhi","Kochi","Mumbai"]
        let locationType : [Int64] = [1,4,0,0,3,2,2]
        let vehicleType : [Int64] = [4,3,2,4,2,0,1]
        let activityCost : [Int64] = [220,270,30,125,300,260,0]
        for val in  0..<placeName.count {
            TRTripDataHandler().addTrip(name: placeName[val], from: Date(), to: Date(), locationType: Int16(locationType[val]), vehicle: Int16(vehicleType[val]), tripID: Int64(val))
            TRExpenseDataHandler().addExpense(vehicle: 10, activity: activityCost[val], roomRent: 10, foodExpense: 10, tripId: Int64(val))
        }
        let friendName = ["Sundar","Mani","Raj","Vel","Kumar","Vinoth","John","Tony","Babu","Saleem","Omer","Sri"]
        let tripID : [Int64] = [0,0,1,1,2,2,3,3,4,4,6,6]
        for val in 0..<friendName.count {
            TRFriendDataHandeler().addFriend(friendName: friendName[val], occupation: "Some Job", meetPlace: "Some PlaceName", phoneNo: "1234567890", tripID: tripID[val])
        }
        let activityName = ["Boating","Cycling","Cinema","Zoo Visit","Estate Visit","View Point","Horse Riding","Taj Mahal Visit","Sea Surfing","Boating","Swimming",]
        let tripIDD : [Int64] = [0,0,1,1,2,3,3,4,5,5,5]
        let cost : [Int64] = [200,20,190,80,30,100,25,300,60,150,50]
        for val in 0..<activityName.count {
            TRActivityDataHandler().addActivity(activityName: activityName[val], date: Date(), duratiuon: 1, cost: cost[val], tripID: tripIDD[val])
        }
    }
}
