//
//  ActivitiesListVC.swift
//  Travel Register
//
//  Created by sunder-con870 on 08/02/22.
//

import UIKit


class TRActivitiesListVC : TRBaseTableViewController<ActivityListCell, TRActivityData
> {
    private var emptyCheck = false
    var currentTripIndex : Int! = -1
    private var noData : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure() {
        title = "Activities"
        label.text = "No Activities Found!!!"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.plus.rawValue), selector: #selector(addNewActivity), view: self)
    }
    @objc func addNewActivity() {
        TRLoginVC.tabBarVCs.activity.addNewActivity(crntView: self, tripIndex: currentTripIndex)
    }
    func reloadData() -> Int{
        let fetch = TRActivityData.fetchRequest()
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
        let vc = TRActivityInfoVC()
        vc.asDisplayActivityView(selectedIndex: indexPath.row, selfView: self, activity: items[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let id  = items[indexPath.row].tripID
            TRActivityInfoVC.deleteActivity(tripID: Int(id), activity: items[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
    deinit {
        print("activityListVC")
    }
}

class ActivityListCell : BaseCell<TRActivityData> {
    override var item: TRActivityData! {
        didSet {
            rightArrowImage.isHidden = true
            textLabel?.text = "\(item.activityName!)"
            accessoryType = .disclosureIndicator
        }
    }
}
