//
//  TabBarActivities.swift
//  Travel Register
//
//  Created by sunder-con870 on 01/02/22.
//

import UIKit

class TRActivities : TRBaseTableViewController<ActivityCell,TRActivityData> , UISearchResultsUpdating{
    
    //Variables
    private var filteredData = [TRActivityData]()
    lazy private var temp = items
    
    //Functions
    ///Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatatoView()
        configureVC()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newActivityInfoView = TRActivityInfoVC()
        newActivityInfoView.asDisplayActivityView(selectedIndex: indexPath.row, selfView : self, activity: items[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let id = TRActivityDataHandler.activityData[indexPath.row].tripID
            TRActivityInfoVC.deleteActivity(tripID: Int(id), activity: items[indexPath.row], isFromSearch: navigationItem.searchController!.isActive)
            if navigationItem.searchController?.isActive == true {
                items.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
    
    ///Normal Functions
    func updateSearchResults(for searchController: UISearchController) {
        filteredData.removeAll()
        guard let text = searchController.searchBar.text else {
            return
        }
        for item in temp {
            if ((item.activityName?.starts(with: text)) == true) {
                filteredData.append(item)
            }
            items = filteredData
            tableView.reloadData()
        }
    }
    func configureVC() {
        title = "Activities"
        label.text = "No Activities Added As So Far!!!"
        TRActions.configureVCHelper(selfVC: self, addSelector: #selector(addActivity), view: view)
    }
    func loadDatatoView() {
        items = TRActivityDataHandler.activityData
        temp = items
        tableView.reloadData()
    }
    func addNewActivity(crntView : UIViewController, tripIndex : Int? = nil) {
        let newActivityInfoView = TRActivityInfoVC()
        newActivityInfoView.asAddActivityView(viewToPresent: crntView)
        if tripIndex != nil {
            newActivityInfoView.asTripViewsAddActivityView(tripIndex: tripIndex!)
        }
    }
    ///Objc Function
    @objc func addActivity() {
        addNewActivity(crntView: self)
    }
}

class ActivityCell : BaseCell<TRActivityData> {
    override var item: TRActivityData! {
        didSet {
            textLabel?.text = "\(TRCurrencyTableVC.getCurrencySymbol())\(Int(Double(item.cost) * TRCurrencyTableVC.crntAmount))"
            textLabel?.font = .systemFont(ofSize: 15)
            configureCellLabels(placeTxt: item.activityName!, days: "\(item.duration) Hrs", date: "\(item.dateNtime!.formatted(date: .numeric, time: .shortened))")
        }
    }
}
