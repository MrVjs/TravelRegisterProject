//
//  ActivityInfoView.swift
//  Travel Register
//
//  Created by sunder-con870 on 12/02/22.
//

import UIKit

class TRActivityInfoVC : UIViewController {
    
    //Variables
    ///Lables
    private let selectLabel = TRWidget.label(name: "Select a Trip To add Activity:")
    private let nameLabel = TRWidget.label(name: "Activity Name:")
    private let dateLabel = TRWidget.label(name: "Date & Time:")
    private let durationLabel = TRWidget.label(name: "Duration       :")
    private let hoursLabel = TRWidget.label(name: "Hour's.")
    private let costLabel = TRWidget.label(name: "Cost               :   \(TRCurrencyTableVC.getCurrencySymbol())")
    ///TextFields
    let tripTextField = TRWidget.textField(placeHolder: "Select a Trip", tintColor: .clear)
    let nameTextField = TRWidget.textField(placeHolder: "Enter Activity Name", tintColor: .systemGray)
    let durationTxtField = TRWidget.textField(placeHolder: "0", tintColor: .systemGray)
    let costTxtField = TRWidget.textField(placeHolder: "0", tintColor: .systemGray)
    
    ///Views
    private var scrollView : UIScrollView!
    let datePicker = UIDatePicker()
    
    ///Datas
    private var isContextIsEditable : Bool!
    private var selectedActivityIndex : Int!
    private var tripListVC : TRTripListVC!
    private var activityData = TRActivityDataHandler()
    private var exp : Int64!
    var currentTripID : Int!
    var selectedTripIndex : Int!
    
    ///Gesture
    private var tapGesture : UITapGestureRecognizer!
    private var toastTap : UITapGestureRecognizer!
    
    //Function
    ///Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: costTxtField.center.y + 25)
    }
    ///Normal Function
    func changeTextFieldProperty(bool : Bool) {
        nameTextField.isUserInteractionEnabled = bool
        datePicker.isUserInteractionEnabled = bool
        durationTxtField.isUserInteractionEnabled = bool
        costTxtField.isUserInteractionEnabled = bool
    }
    func changeUserInteractable() {
        if nameTextField.isUserInteractionEnabled == true {
            changeTextFieldProperty(bool: false)
            tripTextField.isEnabled = false
        } else {
            changeTextFieldProperty(bool: true)
        }
    }
    func asAddActivityView(viewToPresent : UIViewController) {
        TRActions.addNew(newView: self, title: "Add Activity Info", view: self, saveSelector: #selector(saveButtonTrigger), backSelector: #selector(backTapped), presentView: viewToPresent)
    }
    func asDisplayActivityView(selectedIndex : Int, selfView : UIViewController, activity : TRActivityData) {
        selectedActivityIndex = selectedIndex
        isContextIsEditable = false
        currentTripID = Int(activity.tripID)
        changeUserInteractable()
        setTripTextFieldsText()
        loadData(activity : activity)
        title = "Activity Info"
        toastTap = TRWidget.tapGesture(view: self, selector: #selector(enableEditMode), taps: 2)
        TRActions.asDisplayView(view: self, deleteSelector: #selector(deleteActivityData), editSelector: #selector(makeEditable), self: selfView)
        scrollView.addGestureRecognizer(toastTap)
    }
    func loadData(activity : TRActivityData) {
        nameTextField.text = activity.activityName
        datePicker.date = activity.dateNtime!
        durationTxtField.text = String(activity.duration)
        costTxtField.text = String(Int(Double(activity.cost) * TRCurrencyTableVC.crntAmount))
    }
    func setTripTextFieldsText() {
        selectLabel.text = "Activity Added to the Trip of:"
        let fetch = TRTripData.fetchRequest()
        let predicate = NSPredicate(format: "tripID CONTAINS '\(currentTripID!)'")
        fetch.predicate = predicate
        let trip = try! TRDataTool.context.fetch(fetch)
        tripTextField.text = "\(trip.first!.getStartDate()) at \(trip.first!.getPlaceName())"
        datePicker.maximumDate = trip.first!.toDate
        datePicker.minimumDate = trip.first!.fromDate
    }
    func asTripViewsAddActivityView(tripIndex : Int) {
        tripTextField.isEnabled = false
        currentTripID = tripIndex
        nameTextField.becomeFirstResponder()
        setTripTextFieldsText()
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    func configureVC() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.systemGray5.cgColor
        TRWidget.positionMaker(view: scrollView, left: view.leftAnchor, right: view.rightAnchor, top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leftCon: 0, righCon: 0, topCon: 0, bottomCon: 0)
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        nameTextField.delegate = self
        durationTxtField.delegate = self
        costTxtField.delegate = self
        tapGesture = TRWidget.tapGesture(view: self, selector: #selector(presentTripList), taps: 1)
        durationTxtField.keyboardType = .numbersAndPunctuation
        costTxtField.keyboardType = .numbersAndPunctuation
        let width = view.layer.frame.width
        let left = scrollView.safeAreaLayoutGuide.leftAnchor
        let right = scrollView.safeAreaLayoutGuide.rightAnchor
        view.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
        scrollView.addSubview(selectLabel)
        selectLabel.font = .systemFont(ofSize: 20, weight: .thin)
        TRWidget.positionMaker(view: selectLabel, width: width-20, height: 25, left: left, top: scrollView.topAnchor, leftCon: 10, topCon: 20)
        scrollView.addSubview(tripTextField)
        TRWidget.positionMaker(view: tripTextField, height: 40, left: left, top: selectLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        tripTextField.borderStyle = .roundedRect
        tripTextField.backgroundColor = .lightGray.withAlphaComponent(0.2)
        if TRTripDataHandler.tripData.count == 0 {
            tripTextField.isUserInteractionEnabled = false
            tripTextField.text = "No Trip's Found!!!"
        } else {
            tripTextField.isUserInteractionEnabled = true
        }
        tripTextField.addGestureRecognizer(tapGesture)
        scrollView.addSubview(nameLabel)
        TRWidget.positionMaker(view: nameLabel, width: width - 20, height: 25, left: left, top: tripTextField.bottomAnchor, leftCon: 10, topCon: 20)
        scrollView.addSubview(nameTextField)
        nameTextField.tag = 1
        TRWidget.positionMaker(view: nameTextField, height: 35, left: left, top: nameLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(dateLabel)
        TRWidget.positionMaker(view: dateLabel, width: 100, height: 25, left: left, top: nameTextField.bottomAnchor, leftCon: 10, topCon: 19)
        scrollView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        TRWidget.positionMaker(view: datePicker, left: dateLabel.rightAnchor, top: nameTextField.bottomAnchor, leftCon: 15, topCon: 15)
        datePicker.addTarget(self, action: #selector(dateSelected), for: .touchUpOutside)
        scrollView.addSubview(durationLabel)
        TRWidget.positionMaker(view: durationLabel, width: 100, height: 25, left: left, top: datePicker.bottomAnchor, leftCon: 10, topCon: 19)
        scrollView.addSubview(durationTxtField)
        TRWidget.positionMaker(view: durationTxtField, width: width/4, height: 35, left: durationLabel.rightAnchor, top: datePicker.bottomAnchor, leftCon: 15, topCon: 15)
        scrollView.addSubview(hoursLabel)
        TRWidget.positionMaker(view: hoursLabel, width: 70, height: 25, left: durationTxtField.rightAnchor, top: datePicker.bottomAnchor, leftCon: 3, topCon: 19)
        scrollView.addSubview(costLabel)
        TRWidget.positionMaker(view: costLabel, width: 115, height: 25, left: left, top: durationTxtField.bottomAnchor, leftCon: 10, topCon: 19)
        scrollView.addSubview(costTxtField)
        TRWidget.positionMaker(view: costTxtField, width: width/4, height: 35, left: costLabel.rightAnchor, top: durationTxtField.bottomAnchor, leftCon: 0, topCon: 15)
        scrollView.delegate = self
    }
    
    ///Static Function
    static func deleteActivity(tripID : Int, activity : TRActivityData, isFromSearch : Bool = false) {
        let activityCost = activity.cost
        TRActivityDataHandler.deleteActivity(item: activity)
        let expense = TRExpenseDataHandler.fetchTripIDBasedExpense(tripID: Int64(tripID))
        let data = expense.first!.activityExpense - activityCost
        TRExpenseDataHandler.updateExpense(expense: expense.first!, vehicle: expense.first!.vehicleExpense, activity: data, roomRent: expense.first!.roomRentExpense, foodExpense: expense.first!.foodExpense)
        if isFromSearch == false {
            TRLoginVC.tabBarVCs.activity.loadDatatoView()
        }
        TRLoginVC.tabBarVCs.travel.newTripInfoView?.loadTableViewData()
    }
    
    ///Objc Function
    @objc func dismissKeyBoard() {
        nameTextField.resignFirstResponder()
        durationTxtField.resignFirstResponder()
        costTxtField.resignFirstResponder()
    }
    @objc func cancelButtonTapped() {
        makeEditable()
    }
    @objc func makeEditable() {
        if isContextIsEditable == false {
            isContextIsEditable = true
            scrollView.removeGestureRecognizer(toastTap)
            TRActions.enableEdit(view: self, saveSelector: #selector(saveChanges), cancelSelector: #selector(cancelButtonTapped),self: self)
            changeUserInteractable()
            nameTextField.becomeFirstResponder()
            exp = Int64(costTxtField.text!)
        } else {
            isContextIsEditable = false
            scrollView.addGestureRecognizer(toastTap)
            TRActions.disableEdit(view: self, delectSelector: #selector(deleteActivityData), self: self)
            changeUserInteractable()
        }
    }
    @objc func dateSelected() {
        presentedViewController?.dismiss(animated: false, completion: nil)
    }
    @objc func presentTripList() {
        tripListVC = TRTripListVC()
        tripListVC.currentAInfoView = self
        let navi = UINavigationController(rootViewController: tripListVC)
        present(navi, animated: true, completion: nil)
    }
    @objc func saveChanges() {
        makeEditable()
        activityData.updateActivity(activity: TRActivityDataHandler.activityData[selectedActivityIndex],activityName: nameTextField.text!, date: datePicker.date, duratiuon: Double(durationTxtField.text ?? "0.0")!, cost: Int64(costTxtField.text ?? "0")!)
        let expense = TRExpenseDataHandler.fetchTripIDBasedExpense(tripID: Int64(currentTripID))
        expense.first!.activityExpense -= exp
        expense.first!.activityExpense += Int64(costTxtField.text ?? "0")!
        TRExpenseDataHandler.updateExpense(expense: expense.first!, vehicle: expense.first!.vehicleExpense, activity: expense.first!.activityExpense, roomRent: expense.first!.roomRentExpense, foodExpense: expense.first!.foodExpense)
        TRLoginVC.tabBarVCs.activity.loadDatatoView()
        TRLoginVC.tabBarVCs.travel.newTripInfoView?.activitiesVC.tableView.reloadData()
    }
    @objc func deleteActivityData() {
        let yes = UIAlertAction(title: "Yes",
                                style: .destructive) { action in
            TRActivityInfoVC.deleteActivity(tripID: self.currentTripID, activity: TRActivityDataHandler.activityData[self.selectedActivityIndex])
            self.navigationController?.popViewController(animated: true)
        }
        TRActions.delete(currentTripIndex: currentTripID, selectedIndex: selectedActivityIndex, yes: yes, view: self)
    }
    @objc func backTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func saveButtonTrigger() {
        activityData.addActivity(activityName: nameTextField.text!, date: datePicker.date, duratiuon: Double(durationTxtField.text ?? "0.0") ?? 0.0, cost: Int64(costTxtField.text ?? "0") ?? 0, tripID: Int64(currentTripID))
        TRLoginVC.tabBarVCs.activity.loadDatatoView()
        let expense = TRExpenseDataHandler.fetchTripIDBasedExpense(tripID: Int64(currentTripID))
        expense.first!.activityExpense += Int64(costTxtField.text ?? "0") ?? 0
        TRExpenseDataHandler.updateExpense(expense: expense.first!, vehicle: expense.first!.vehicleExpense, activity: expense.first!.activityExpense, roomRent: expense.first!.roomRentExpense, foodExpense: expense.first!.foodExpense)
        TRExpenseDataHandler.reteriveAllExpenses()
        _ = TRLoginVC.tabBarVCs.travel.newTripInfoView?.activitiesVC.reloadData()
        TRLoginVC.tabBarVCs.travel.newTripInfoView?.loadTableViewData()
        TRLoginVC.tabBarVCs.home.update()
        backTapped()
    }
    @objc func enableEditMode() {
        TRActions.showToast(message: "Enable Edit to Edit the Data's!!!", window: view.window!)
    }
}

extension TRActivityInfoVC : UITextFieldDelegate, UIScrollViewDelegate {
    
    ///Functions
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchTxtFieldAsResponder(textField: textField)
        return true
    }
    func switchTxtFieldAsResponder(textField : UITextField) {
        switch textField {
        case self.nameTextField:
            self.durationTxtField.becomeFirstResponder()
        case self.durationTxtField:
            self.costTxtField.becomeFirstResponder()
        default:
            self.costTxtField.resignFirstResponder()
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag != 1 {
            return range.location < 5
        }
        return range.location < 50
    }
}
