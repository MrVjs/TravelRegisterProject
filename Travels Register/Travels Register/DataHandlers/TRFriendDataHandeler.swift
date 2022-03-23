//
//  FriendDetails.swift
//  Travels Register
//
//  Created by sunder-con870 on 28/02/22.
//

import UIKit

class TRFriendDataHandeler {
    
    static var friendData = [TRFriendsData]()
    static func reteriveAllFriends() {
        do {
            TRFriendDataHandeler.friendData = try TRDataTool.context.fetch(TRFriendsData.fetchRequest())
        } catch {
            print("Error")
        }
    }
    func addFriend(friendName : String, occupation : String, meetPlace : String, phoneNo : String, tripID : Int64) {
        let newFriend = TRFriendsData(context: TRDataTool.context)
        newFriend.tripID = tripID
        updateFriend(friend: newFriend, friendName: friendName, occupation: occupation, meetPlace: meetPlace, phoneNo: phoneNo)
    }
    static func deleteFriend(item : TRFriendsData) {
        TRDataTool.context.delete(item)
        do {
            try TRDataTool.context.save()
//            TRLoginVC.tabBarVCs.friends.loadDatatoView()
            TRFriendDataHandeler.reteriveAllFriends()
        } catch {
            print("Error")
        }
    }
    func updateFriend(friend : TRFriendsData,friendName : String, occupation : String, meetPlace : String, phoneNo : String) {
        friend.friendName = friendName
        friend.occupation = occupation
        friend.meetPlace = meetPlace
        friend.phoneNo = phoneNo
        do {
            try TRDataTool.context.save()
            TRLoginVC.tabBarVCs.friends.loadDatatoView()
            TRFriendDataHandeler.reteriveAllFriends()
        } catch {
            print("Error")
        }
    }
    static func getNoofFriends() -> Int{
        return TRFriendDataHandeler.friendData.count
    }

}
