//
//  TabBarFriends.swift
//  Travel Register
//
//  Created by sunder-con870 on 01/02/22.
//

import UIKit

class TRFriends : TRBaseTableViewController<FriendCell, TRFriendsData> , UISearchResultsUpdating{
    
    //Variables
    private var filteredData = [TRFriendsData]()
    lazy private var temp = items
    //Functions
    ///Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatatoView()
        configureVC()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newFriendsInfoView = TRFriendInfoVC()
        newFriendsInfoView.asDisplayFriendView(selectedIndex: indexPath.row, selfView : self, friend: items[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            TRFriendInfoVC.deleteFriend(friend : items[indexPath.row], isFromSearch : navigationItem.searchController!.isActive)
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
            if ((item.friendName?.starts(with: text)) == true) {
                filteredData.append(item)
            }
            items = filteredData
            tableView.reloadData()
        }
    }
    func configureVC() {
        title = "Friends"
        label.text = "No Friends Added As So Far!!!"
        TRActions.configureVCHelper(selfVC: self, addSelector: #selector(addFriend), view: view)
    }
    
    func loadDatatoView() {
        items = TRFriendDataHandeler.friendData
        temp = items
        tableView.reloadData()
    }
    func addNewFriend(presentView : UIViewController, tripIndex : Int? = nil) {
        let newFriendsInfoView = TRFriendInfoVC()
        newFriendsInfoView.asAddFriendView(viewToPresent: presentView)
        if tripIndex != nil {
            newFriendsInfoView.asTripViewsAddFriendView(tripIndex: tripIndex!)
        }
    }
    
    ///@Objc Function
    @objc func addFriend() {
        addNewFriend(presentView: self)
    }
}

class FriendCell : BaseCell<TRFriendsData> {
    override var item: TRFriendsData! {
        didSet {
            imageView?.image = UIImage(systemName: "person.fill")
            configureCellLabels(placeTxt: item.friendName!, days: item.phoneNo!, date: item.meetPlace!)
        }
    }
}
