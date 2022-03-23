//
//  ActivityDetails.swift
//  Travels Register
//
//  Created by sunder-con870 on 28/02/22.
//

import UIKit

class TRActivityDataHandler {
    
    static var activityData = [TRActivityData]()
    static func reteriveAllActivities() {
        do {
            TRActivityDataHandler.activityData = try TRDataTool.context.fetch(TRActivityData.fetchRequest())
        } catch {
            
        }
    }
    func addActivity(activityName : String,date : Date, duratiuon : Double, cost : Int64, tripID : Int64) {
        let newActivity = TRActivityData(context: TRDataTool.context)
        newActivity.tripID = tripID
        updateActivity(activity: newActivity, activityName: activityName, date: date, duratiuon: duratiuon, cost: cost)
    }
    static func deleteActivity(item : TRActivityData) {
        TRDataTool.context.delete(item)
        do {
            try TRDataTool.context.save()
            TRActivityDataHandler.reteriveAllActivities()
        } catch {
            
        }
    }
    func updateActivity(activity : TRActivityData, activityName : String,date : Date, duratiuon : Double, cost : Int64) {
        activity.activityName = activityName
        activity.dateNtime = date
        activity.duration = duratiuon
        activity.cost = cost
        do {
            try TRDataTool.context.save()
            TRLoginVC.tabBarVCs.activity.loadDatatoView()
            TRActivityDataHandler.reteriveAllActivities()
        } catch {
            
        }
    }

    static func getNoOfActivities() -> Int{
        return TRActivityDataHandler.activityData.count
    }

}
