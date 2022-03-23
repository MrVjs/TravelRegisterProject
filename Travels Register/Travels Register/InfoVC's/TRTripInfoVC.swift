//
//  TripInfoView.swift
//  Travel Register
//
//  Created by sunder-con870 on 03/02/22.
//

import UIKit

class TRTripInfoVC : UIViewController {
    
    //Variables
    ///Labels
    private let placeNameLabel = TRWidget.label(name: "Place Name:")
    private let durationLabel = TRWidget.label(name: "Trip Duration:")
    private let fromLabel = TRWidget.label(name: "From")
    private let toLabel = TRWidget.label(name: "To")
    private let locationTypeLabel = TRWidget.label(name: "Location Type:")
    private let usedTransportLabel = TRWidget.label(name: "Used Transport:")
    
    ///TextFields
    let placeNameTxtField = TRWidget.textField(placeHolder: "Enter Place Name", tintColor: .systemGray)
    let locationTypeTxtField = TRWidget.textField(placeHolder: "Select Location Type", tintColor: .clear)
    let transportTypeTxtField = TRWidget.textField(placeHolder: "Select Transport Type", tintColor: .clear)
    
    ///Views
    private let tableView : UITableView = {
        let tv = UITableView()
        tv.isUserInteractionEnabled = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let downArrow = UIImageView(image: UIImage(systemName: "chevron.down"))
    private let downArrow2 = UIImageView(image: UIImage(systemName: "chevron.down"))
    private var vcForTableViews : [UIViewController]!
    private var scrollView : UIScrollView!
    private let locationTypePicker = UIPickerView()
    private let transportTypePicker = UIPickerView()
    let fromDatePicker = UIDatePicker()
    let toDatePicker = UIDatePicker()
    
    ///Datas
    private lazy var width = view.frame.width
    private lazy var height = view.frame.height
    private var tableHeight : CGFloat!
    private var selectedTripIndex : Int!
    private var imgForTableView : [String]!
    private var namesForTableCells : [String]!
    private var locationId : Int16 = 0
    private var vehicleId : Int16 = 0
    private var isContextIsEditable : Bool!
    var numberOfRowInTable : Int!
    var tripDatas = TRTripDataHandler()
    var expenseVC : TRExpenseVC! = TRExpenseVC()
    var friendsVC : TRFriendsListVC! = TRFriendsListVC()
    var activitiesVC : TRActivitiesListVC! = TRActivitiesListVC()
    var currencyImg : String = "indianrupeesign.circle"
    var currentTripID : Int!
    
    ///Gesture
    private var toastTap : UITapGestureRecognizer!
    
    //Function
    ///Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: tableView.center.y + 85)
    }
    
    ///Normal Functions
    private func configureVC() {
        placeNameTxtField.delegate = self
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.systemGray5.cgColor
        TRWidget.positionMaker(view: scrollView, left: view.leftAnchor, right: view.rightAnchor, top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leftCon: 0, righCon: 0, topCon: 0, bottomCon: 0)
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        if let val = TRDataTool.userDefault.value(forKey: "currencyName") as? Int {
            currencyImg = TRCurrency.allCases[val].rawValue
        }
        let left = scrollView.safeAreaLayoutGuide.leftAnchor
        let right = scrollView.safeAreaLayoutGuide.rightAnchor
        imgForTableView = [currencyImg,"person.2.circle","figure.walk.circle"]
        locationTypePicker.delegate = self
        locationTypePicker.dataSource = self
        locationTypePicker.tag = 1
        transportTypePicker.delegate = self
        transportTypePicker.dataSource = self
        transportTypePicker.tag = 2
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemGray6
        scrollView.addSubview(placeNameLabel)
        TRWidget.positionMaker(view: placeNameLabel, width: view.frame.width-20, height: 25, left: left, top: scrollView.topAnchor, leftCon: 10, topCon: 20)
        placeNameTxtField.becomeFirstResponder()
        scrollView.addSubview(placeNameTxtField)
        TRWidget.positionMaker(view: placeNameTxtField, height: 35, left: left, top: placeNameLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(durationLabel)
        TRWidget.positionMaker(view: durationLabel, width: view.frame.width-20, height: 25, left: left, top: placeNameTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(fromLabel)
        TRWidget.positionMaker(view: fromLabel, width: 80, height: 25, left: left, top: durationLabel.bottomAnchor, leftCon: 10, topCon: 14)
        scrollView.addSubview(fromDatePicker)
        TRWidget.positionMaker(view: fromDatePicker, left: fromLabel.rightAnchor, top: durationLabel.bottomAnchor, leftCon: 10, topCon: 10)
        fromDatePicker.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(toLabel)
        TRWidget.positionMaker(view: toLabel, width: 80, height: 25, left: left, top: fromDatePicker.bottomAnchor, leftCon: 10, topCon: 14)
        scrollView.addSubview(toDatePicker)
        TRWidget.positionMaker(view: toDatePicker, left: toLabel.rightAnchor, top: fromDatePicker.bottomAnchor, leftCon: 10, topCon: 10)
        toDatePicker.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(locationTypeLabel)
        TRWidget.positionMaker(view: locationTypeLabel, width: view.frame.width-20, height: 25, left: left, top: toDatePicker.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(locationTypeTxtField)
        locationTypeTxtField.clearButtonMode = .never
        scrollView.addSubview(downArrow)
        downArrow.translatesAutoresizingMaskIntoConstraints = false
        TRWidget.positionMaker(view: downArrow, right: locationTypeTxtField.rightAnchor, bottom: locationTypeTxtField.bottomAnchor, width: 15, height: 20, rightCon: -10, bottomCon: -7.5)
        locationTypeTxtField.inputView = locationTypePicker
        locationTypeTxtField.inputAccessoryView = addToolBar(selector: #selector(doneLocationSelection))
        TRWidget.positionMaker(view: locationTypeTxtField, height: 35, left: left, top: locationTypeLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(usedTransportLabel)
        TRWidget.positionMaker(view: usedTransportLabel, width: view.frame.width-20, height: 25, left: left, top: locationTypeTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(transportTypeTxtField)
        transportTypeTxtField.inputView = transportTypePicker
        transportTypeTxtField.inputAccessoryView = addToolBar(selector: #selector(doneVehicleSelection))
        TRWidget.positionMaker(view: transportTypeTxtField, height: 35, left: left, top: usedTransportLabel.bottomAnchor, right: right,
                               leftCon: 10, topCon: 0, rightCon: -10)
        transportTypeTxtField.clearButtonMode = .never
        downArrow2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(downArrow2)
        TRWidget.positionMaker(view: downArrow2, right: transportTypeTxtField.rightAnchor, bottom: transportTypeTxtField.bottomAnchor, width: 15, height: 20, rightCon: -10, bottomCon: -7.5)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadTableViewData()
        vcForTableViews = [expenseVC,friendsVC,activitiesVC]
        fromDatePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        fromDatePicker.maximumDate = .now
        toDatePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        toDatePicker.minimumDate = fromDatePicker.date
        toDatePicker.maximumDate = .now
        scrollView.delegate = self
        scrollView.addSubview(tableView)
        TRWidget.positionMaker(view: tableView, height: tableHeight, left: left, top: transportTypeTxtField.bottomAnchor, right: right, leftCon: 10, topCon: 20, rightCon: -10)
    }
    func addToolBar(selector : Selector) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
        toolBar.setItems([space,done], animated: true)
        return toolBar
    }
    func expenseSave() {
        loadTableViewData()
    }
    func loadTableViewData() {
        let friendsCount =  friendsVC?.reloadData()
        let activityCount = activitiesVC?.reloadData()
        namesForTableCells =  ["Trip Expenses : \(TRCurrencyTableVC.getCurrencySymbol()) \(expenseVC.getCurrentExpense())", "Trip Friends    : \(friendsCount ?? 0)", "Trip Activities : \(activityCount ?? 0)"]
        tableView.reloadData()
    }
    func changeTextFieldProperty(bool : Bool) {
        placeNameTxtField.isUserInteractionEnabled = bool
        fromDatePicker.isUserInteractionEnabled = bool
        toDatePicker.isUserInteractionEnabled = bool
        locationTypeTxtField.isUserInteractionEnabled = bool
        transportTypeTxtField.isUserInteractionEnabled = bool
        placeNameTxtField.becomeFirstResponder()
        expenseVC.setUserInteraction()
        downArrow.isHidden = !bool
        downArrow2.isHidden = !bool
    }
    func changeUserInteractable() {
        if placeNameTxtField.isUserInteractionEnabled == true {
            changeTextFieldProperty(bool: false)
        } else {
            changeTextFieldProperty(bool: true)
        }
    }
    func asAddTripView(viewToPresent : UIViewController) {
        tableHeight = 50
        numberOfRowInTable = 1
        TRActions.addNew(newView: self, title: "Add Travel Info", view: self, saveSelector: #selector(saveButtonTrigger), backSelector: #selector(backTapped), presentView: viewToPresent)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    func asDisplayTripView(selectedIndex : Int, selfView : UIViewController, trip : TRTripData) {
        tableHeight = 150
        numberOfRowInTable = 3
        isContextIsEditable = false
        selectedTripIndex = selectedIndex
        loadData(trip : trip)
        currentTripID = Int(trip.tripID)
        expenseVC.loadData(id: currentTripID)
        friendsVC.currentTripIndex = currentTripID
        activitiesVC.currentTripIndex = currentTripID
        title = "Trip Info"
        toastTap = TRWidget.tapGesture(view: self, selector: #selector(makeEditableMessage), taps: 2)
        TRActions.asDisplayView(view: self, deleteSelector: #selector(deleteTripData), editSelector: #selector(makeEditable), self: selfView)
        scrollView.addGestureRecognizer(toastTap)
        changeUserInteractable()
    }
    func loadData(trip : TRTripData) {
        let trip = trip
        placeNameTxtField.text = trip.placeName
        fromDatePicker.date = trip.fromDate!
        toDatePicker.date = trip.toDate!
        locationTypeTxtField.text = trip.locationType != -1 ? "\(TRLocationType(rawValue: trip.locationType)!)" : "----"
        transportTypeTxtField.text = trip.usedTransport != -1 ? "\(TRTransportType(rawValue: trip.usedTransport)!)" : "----"
            locationTypePicker.selectRow(Int(trip.locationType), inComponent: 0, animated: false)
    }
    
    ///Static Functions
    static func deleteTrip(selectIndex : Int, tripID : Int, trip : TRTripData, isFromSearch : Bool = false) {
        TRTripDataHandler.deleteTrip(item: trip)
        
        for friend in TRFriendDataHandeler.friendData {
            if friend.tripID == tripID {
                TRFriendDataHandeler.deleteFriend(item: friend)
            }
        }
        for activity in TRActivityDataHandler.activityData {
            if activity.tripID == tripID {
                TRActivityDataHandler.deleteActivity(item: activity)
            }
        }
        if isFromSearch == false {
            TRLoginVC.tabBarVCs.travel.loadDatatoView()
        }
        TRExpenseDataHandler.reteriveAllExpenses()
        TRExpenseDataHandler.deleteExpense(item: TRExpenseVC.getExpData(id: tripID))
        TRLoginVC.tabBarVCs.activity.loadDatatoView()
        TRLoginVC.tabBarVCs.friends.loadDatatoView()
    }
    
    ///Objc Functions
    @objc func makeEditableMessage() {
        TRActions.showToast(message: "Enable Edit to Edit the Data's!!!", window: view.window!)
    }
    @objc func doneVehicleSelection() {
        transportTypeTxtField.text = "\(TRTransportType(rawValue: vehicleId)!)"
        transportTypeTxtField.resignFirstResponder()
    }
    @objc func doneLocationSelection() {
        locationTypeTxtField.text = "\(TRLocationType(rawValue: locationId)!)"
        locationTypeTxtField.resignFirstResponder()
    }
    @objc func dismissKeyBoard() {
        locationTypeTxtField.resignFirstResponder()
        transportTypeTxtField.resignFirstResponder()
        placeNameTxtField.resignFirstResponder()
    }
    @objc func dateSelected() {
        toDatePicker.minimumDate = fromDatePicker.date
    }
    @objc func deleteTripData() {
        let yes = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.navigationController?.popViewController(animated: true)
            TRTripInfoVC.deleteTrip(selectIndex: self.selectedTripIndex, tripID: self.currentTripID, trip: TRTripDataHandler.tripData[self.selectedTripIndex])
        }
        TRActions.delete(currentTripIndex: 0, selectedIndex: 0, yes: yes, view: self)
    }
    @objc func cancelButtonTapped() {
        makeEditable()
    }
    @objc func saveChanges() {
        makeEditable()
        tripDatas.updateTrip(trip: TRTripDataHandler.tripData[selectedTripIndex], name: placeNameTxtField.text!, from: fromDatePicker.date, to: toDatePicker.date, locationType: locationId, vehicle: vehicleId)
        expenseVC.updateExp(index: selectedTripIndex)
        TRLoginVC.tabBarVCs.travel.loadDatatoView()
    }
    @objc func makeEditable() {
        if isContextIsEditable == false {
            isContextIsEditable = true
            scrollView.removeGestureRecognizer(toastTap)
            TRActions.enableEdit(view: self, saveSelector: #selector(saveChanges), cancelSelector: #selector(cancelButtonTapped), self: self)
            changeUserInteractable()
        } else {
            isContextIsEditable = false
            scrollView.addGestureRecognizer(toastTap)
            TRActions.disableEdit(view: self, delectSelector: #selector(deleteTripData), self: self)
            changeUserInteractable()
        }
    }
    @objc func backTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func saveButtonTrigger() {
        let id = TRTripDataHandler.tripData.last?.tripID ?? -1
        currentTripID = Int(id + 1)
        tripDatas.addTrip(name: placeNameTxtField.text!, from: fromDatePicker.date, to: toDatePicker.date, locationType: locationId, vehicle: vehicleId, tripID: Int64(currentTripID))
        TRLoginVC.tabBarVCs.travel.loadDatatoView()
        expenseVC.saveExp()
        TRLoginVC.tabBarVCs.home.update()
        backTapped()
    }
}

extension TRTripInfoVC : UITableViewDelegate, UITableViewDataSource {
    ///Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowInTable
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesForTableCells[indexPath.row]
        cell.imageView?.image = UIImage(systemName: imgForTableView[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendsVC.currentTripIndex = currentTripID ?? nil
        activitiesVC.currentTripIndex = currentTripID ?? nil
        let vc = vcForTableViews[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TRTripInfoVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIScrollViewDelegate {
    ///Functions
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? TRLocationType.allCases.count : TRTransportType.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? "\(TRLocationType(rawValue: Int16(row))!)" : "\(TRTransportType(rawValue: Int16(row))!)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            locationId = Int16(row)
        } else {
            vehicleId = Int16(row)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 30
    }
}
