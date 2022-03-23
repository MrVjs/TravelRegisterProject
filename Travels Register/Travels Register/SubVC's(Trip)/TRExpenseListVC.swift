//
//  TRExpenseListVC.swift
//  Travels Register
//
//  Created by sunder-con870 on 22/03/22.
//

import UIKit

class TRExpenseListVC : TRBaseTableViewController<ExpenseListCell, TRExpenseData> {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure() {
        title = "Trip's Expense"
        label.text = "No Expense's Found!!!"
        items = TRExpenseDataHandler.expenseData
        view.backgroundColor = .systemBackground
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TRExpenseVC()
        vc.isDisplay = true
        vc.loadData(id: Int(items[indexPath.row].tripID))
        navigationController?.pushViewController(vc, animated: true)
        vc.setUserInteraction()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class ExpenseListCell : BaseCell<TRExpenseData> {
    override var item: TRExpenseData! {
        didSet {
            rightArrowImage.isHidden = true
            textLabel?.text = "\(getTripName(id: item.tripID)) : \(TRCurrencyTableVC.getCurrencySymbol()) \(item.activityExpense + item.foodExpense + item.roomRentExpense + item.vehicleExpense)"
            accessoryType = .disclosureIndicator
        }
    }
    func getTripName(id : Int64) -> String{
        for trip in TRTripDataHandler.tripData {
            if trip.tripID == id {
                return "\(trip.getStartDate()) on \(trip.getPlaceName())"
            }
        }
        return ""
    }
}
