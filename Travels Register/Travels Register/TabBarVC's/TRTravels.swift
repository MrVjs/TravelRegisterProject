//
//  TabBarTravels.swift
//  Travel Register
//
//  Created by sunder-con870 on 01/02/22.
//

import UIKit


class TRTravels : TRBaseTableViewController<TravelCell, TRTripData> , UISearchResultsUpdating {
   
    //Variables
    private var filteredData = [TRTripData]()
    lazy private var temp = items
    weak var newTripInfoView : TRTripInfoVC!
    var selectedTripsIndex : Int!
    
    //Functions
    ///Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatatoView()
        configureVC()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newTripInfoView = TRTripInfoVC()
        self.newTripInfoView = newTripInfoView
        newTripInfoView.asDisplayTripView(selectedIndex: indexPath.row, selfView: self, trip: items[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let id  = items[indexPath.row].tripID
            TRTripInfoVC.deleteTrip(selectIndex: indexPath.row, tripID: Int(id), trip: items[indexPath.row], isFromSearch: navigationItem.searchController!.isActive)
            if navigationItem.searchController!.isActive == true {
                items.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
    
    ///Normal Functions
    func configureVC() {
        title = "Travel's"
        label.text = "No Trip's Added As So Far!!!"
        TRActions.configureVCHelper(selfVC: self, addSelector: #selector(addTrip), view: view)
    }
    func updateSearchResults(for searchController: UISearchController) {
        filteredData.removeAll()
        guard let text = searchController.searchBar.text else {
            return
        }
        for item in temp {
            if ((item.placeName?.starts(with: text)) == true) {
                filteredData.append(item)
            }
            items = filteredData
            tableView.reloadData()
        }
    }
    func loadDatatoView() {
        items = TRTripDataHandler.tripData
        temp = items
        tableView.reloadData()
    }
    func addNewTrip(crntView : UIViewController) {
        let newTripInfoView = TRTripInfoVC()
        self.newTripInfoView = newTripInfoView
        newTripInfoView.asAddTripView(viewToPresent: crntView)
    }
    
    ///Objc Functions
    @objc func addTrip() {
        addNewTrip(crntView: self)
    }
}

class TravelCell : BaseCell<TRTripData> {
    override var item: TRTripData! {
        didSet {
            imageView?.image = UIImage(systemName: item.getVehicleType())
            configureCellLabels(placeTxt: "Trip of \(item.getPlaceName())", days: "\(item.getNoOfDays()) day's", date: item.getStartDate())
        }
    }
}
