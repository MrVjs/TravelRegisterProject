//
//  BaseTableViewController.swift
//  Travel Register
//
//  Created by sunder-con870 on 15/02/22.
//

import UIKit

class TRBaseTableViewController<T: BaseCell<U>, U> :UITableViewController {
    private var noData : UIView!
    var label = UILabel()
    private let cellID = "cell"
    var items = [U]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(T.self, forCellReuseIdentifier: cellID)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            noData?.removeFromSuperview()
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .thin)
            noData = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height-287))
            label.frame = noData.bounds
            noData.addSubview(label)
            view.addSubview(noData)
        } else {
            noData?.removeFromSuperview()
            noData = nil
        }
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
}
