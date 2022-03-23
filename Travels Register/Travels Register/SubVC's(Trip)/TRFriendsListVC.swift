//
//  FirendsListVC.swift
//  Travel Register
//
//  Created by sunder-con870 on 08/02/22.
//

import UIKit

class TRFriendsListVC : TRBaseTableViewController<FriendListCell, TRFriendsData> {
    private var emptyCheck = false
    private var noData : UIView!
    var currentTripIndex : Int! = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure() {
        title = "Friends"
        label.text = "No Friend's Found!!!"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.plus.rawValue), selector: #selector(addNewFriend), view: self)
    }
    @objc func addNewFriend() {
        TRLoginVC.tabBarVCs.friends.addNewFriend(presentView: self, tripIndex: currentTripIndex)
    }
    func reloadData() -> Int{
        let fetch = TRFriendsData.fetchRequest()
        let predicate = NSPredicate(format: "tripID CONTAINS '\(currentTripIndex ?? -1)'")
        fetch.predicate = predicate
        items = try! TRDataTool.context.fetch(fetch)
        tableView.reloadData()
        return items.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TRFriendInfoVC()
        vc.asDisplayFriendView(selectedIndex: indexPath.row, selfView: self, friend: items[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            TRFriendInfoVC.deleteFriend(friend: items[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
    deinit {
        print("friendListVC")
    }
}

class FriendListCell : BaseCell<TRFriendsData> {
    override var item: TRFriendsData! {
        didSet {
            rightArrowImage.isHidden = true
            textLabel?.text = "\(item.friendName!)"
            accessoryType = .disclosureIndicator
        }
    }
}
