//
//  TripListVC.swift
//  Travel Register
//
//  Created by sunder-con870 on 23/02/22.
//

import UIKit

class TRTripListVC : TRBaseTableViewController<TravelCell, TRTripData> {
    weak var currentFInfoView : TRFriendInfoVC!
    weak var currentAInfoView : TRActivityInfoVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    private func configureVC() {
        title = "Trip List"
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem.button(name: "Cancel", selector: #selector(cancelTapped), view: self)
        loadTripList()
        
    }
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    func loadTripList() {
        items = TRTripDataHandler.tripData
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentFInfoView != nil {
            currentFInfoView.tripTextField.text = "\(TRTripDataHandler.tripData[indexPath.row].getStartDate()) at \(TRTripDataHandler.tripData[indexPath.row].getPlaceName())"
            currentFInfoView.navigationItem.rightBarButtonItem?.isEnabled = true
            currentFInfoView.currentTripID = Int(items[indexPath.row].tripID)
            currentFInfoView.selectedTripIndex = indexPath.row
            currentFInfoView.nameTxtField.becomeFirstResponder()
        } else {
            currentAInfoView.tripTextField.text = "\(TRTripDataHandler.tripData[indexPath.row].getStartDate()) at \(TRTripDataHandler.tripData[indexPath.row].getPlaceName())"
            currentAInfoView.navigationItem.rightBarButtonItem?.isEnabled = true
            currentAInfoView.currentTripID = Int(items[indexPath.row].tripID)
            currentAInfoView.datePicker.minimumDate = TRTripDataHandler.tripData[indexPath.row].fromDate
            currentAInfoView.datePicker.maximumDate = TRTripDataHandler.tripData[indexPath.row].toDate
            currentAInfoView.selectedTripIndex = indexPath.row
            currentAInfoView.nameTextField.becomeFirstResponder()
        }
        dismiss(animated: true)
    }
}
