//
//  ExpenseDetails.swift
//  Travels Register
//
//  Created by sunder-con870 on 28/02/22.
//

import UIKit

class TRExpenseDataHandler {
    
    static var expenseData = [TRExpenseData]()
    static func reteriveAllExpenses() {
        do {
            TRExpenseDataHandler.expenseData = try TRDataTool.context.fetch(TRExpenseData.fetchRequest())
        } catch {
            print("Error")
        }
    }
    func addExpense(vehicle : Int64, activity : Int64, roomRent : Int64, foodExpense : Int64, tripId : Int64) {
        let newExpense = TRExpenseData(context: TRDataTool.context)
        newExpense.tripID = tripId
        TRExpenseDataHandler.updateExpense(expense: newExpense, vehicle: vehicle, activity: activity, roomRent: roomRent, foodExpense: foodExpense)
    }
    static func deleteExpense(item : TRExpenseData) {
        TRDataTool.context.delete(item)
        do {
            try TRDataTool.context.save()
            TRExpenseDataHandler.reteriveAllExpenses()
        } catch {
            
        }
    }
    static func updateExpense(expense : TRExpenseData,vehicle : Int64, activity : Int64, roomRent : Int64, foodExpense : Int64) {
        expense.vehicleExpense = vehicle
        expense.activityExpense = activity
        expense.roomRentExpense = roomRent
        expense.foodExpense = foodExpense
        
        do {
            try TRDataTool.context.save()
            TRExpenseDataHandler.reteriveAllExpenses()
        } catch {
            
        }
    }
    func addActivityExpense(expense : TRExpenseData, activity : Int64) {
        expense.activityExpense += activity
    }
    
    static func getTotalExpenses() -> Int64 {
        var totalExp : Int64 = 0
        for trip in TRExpenseDataHandler.expenseData {
            totalExp += trip.activityExpense + trip.vehicleExpense + trip.roomRentExpense + trip.foodExpense
        }
        return totalExp
    }
    static func getLastExpense() -> Int64 {
        let c = TRTripDataHandler.getNoOfTrip()
        return c != 0 ? TRExpenseDataHandler.getExpense(index: c-1) : 0
    }
    static func getExpense(index : Int!) -> Int64{
        if index != nil {
            let d = TRExpenseDataHandler.expenseData[index]
            return d.activityExpense + d.vehicleExpense + d.roomRentExpense + d.foodExpense
        }
        return 0
    }
    static func fetchTripIDBasedExpense(tripID : Int64) -> [TRExpenseData]{
        let fetch = TRExpenseData.fetchRequest()
        let predicate = NSPredicate(format: "tripID CONTAINS '\(tripID)'")
        fetch.predicate = predicate
        return try! TRDataTool.context.fetch(fetch)
    }
}
