//
//  TRCurrencyTableVC.swift
//  Travels Register
//
//  Created by sunder-con870 on 03/03/22.
//

import UIKit
import CloudKit

protocol CurrencySelectionDelegate {
    func didTapCurrency(name : String)
}
class TRCurrencyTableVC : TRBaseTableViewController<CurrencyCell, TRCurrency> {
    
    static var crntAmount : Double = 1
    var selectionDelegate : CurrencySelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    func configureVC() {
        title = "Select Currency"
        navigationItem.leftBarButtonItem = UIBarButtonItem.button(name: "Cancel", selector: #selector(cancelTapped), view: self)
        items = TRCurrency.allCases
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectionDelegate.didTapCurrency(name: "\(TRCurrency.allCases[indexPath.row])")
        TRDataTool.userDefault.setValue(indexPath.row, forKey: "currencyName")
        TRApiCall.getCurrencyValue(name: TRCurrency.shortNames[indexPath.row])
        TRLoginVC.tabBarVCs.home.update()
        TRLoginVC.tabBarVCs.activity.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    static func getCurrencySymbol() -> String {
        var symbol : String!
        if let value = TRDataTool.userDefault.value(forKey: "currencyName") as? Int {
            symbol = TRCurrency.symbol[value]
        }
        return symbol ?? "₹"
    }
    
}

class CurrencyCell : BaseCell<TRCurrency> {
    override var item: TRCurrency! {
        didSet {
            imageView?.image = UIImage(systemName: item.rawValue)
            textLabel?.text = "\(item!)"
            rightArrowImage.isHidden = true
        }
    }
}


