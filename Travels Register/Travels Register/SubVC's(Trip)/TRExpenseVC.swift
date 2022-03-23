//
//  ExpenseVC.swift
//  Travel Register
//
//  Created by sunder-con870 on 08/02/22.
//

import UIKit

class TRExpenseVC : UIViewController {
    
    private var scrollView : UIScrollView!
    private var isEditable : Bool = true
    var isDisplay : Bool = false
    var expenceData = TRExpenseDataHandler()
    private var toastTap : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    private let vehicleExpenseLabel = TRWidget.label(name: "Vehicle Expense:")
    let vehicleExpenseTxtField = TRWidget.textField(placeHolder: "Enter Vehicle Expense", tintColor: .systemGray)
    private let activityExpenseLabel = TRWidget.label(name: "Activity Expense:")
    let activityExpenseTxtField = TRWidget.textField(placeHolder: "0", tintColor: .clear)
    private let roomRentExpenseLabel = TRWidget.label(name: "Room Rent Expense:")
    let roomRentExpenseTxtField = TRWidget.textField(placeHolder: "Enter Rent Expense", tintColor: .systemGray)
    private let foodExpenceLabel = TRWidget.label(name: "Food Expense:")
    let foodExpenseTxtField = TRWidget.textField(placeHolder: "Enter Food Expense", tintColor: .systemGray)
    @objc func clearTextFields() {
        vehicleExpenseTxtField.text = ""
        roomRentExpenseTxtField.text = ""
        foodExpenseTxtField.text = ""
    }
    @objc func save() {
        TRLoginVC.tabBarVCs.travel.newTripInfoView.loadTableViewData()
        _ = navigationController?.popViewController(animated: true)
    }
    @objc func edit() {
        TRLoginVC.tabBarVCs.travel.newTripInfoView.makeEditable()
        vehicleExpenseTxtField.becomeFirstResponder()
    }
    func placeSaveButton() {
        if isEditable {
            navigationItem.rightBarButtonItem = UIBarButtonItem.button(name : "Save", selector: #selector(save), view: self)
            scrollView?.removeGestureRecognizer(toastTap)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem.button(name: "Edit", selector: #selector(edit), view: self)
            if let tap = toastTap {
                scrollView?.addGestureRecognizer(tap)
            }
        }
    }
    func configureVC() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.systemGray5.cgColor
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        TRWidget.positionMaker(view: scrollView, left: view.leftAnchor, right: view.rightAnchor, top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leftCon: 0, righCon: 0, topCon: 0, bottomCon: 0)
        
        let left = scrollView.safeAreaLayoutGuide.leftAnchor
        let right = view.safeAreaLayoutGuide.rightAnchor
        scrollView.delegate = self
        title = "Expenses \(TRCurrencyTableVC.getCurrencySymbol())"
        view.backgroundColor = .systemGray6
        if !isDisplay {
            placeSaveButton()
        }
        scrollView.addSubview(vehicleExpenseLabel)
        TRWidget.positionMaker(view: vehicleExpenseLabel, width: view.frame.width - 20, height: 25, left: left, top: scrollView.topAnchor, leftCon: 10, topCon: 20)
        scrollView.addSubview(vehicleExpenseTxtField)
        vehicleExpenseTxtField.keyboardType = .numberPad
        vehicleExpenseTxtField.becomeFirstResponder()
        TRWidget.positionMaker(view: vehicleExpenseTxtField, height: 35, left: left, top: vehicleExpenseLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(activityExpenseLabel)
        TRWidget.positionMaker(view: activityExpenseLabel, width: view.frame.width - 20, height: 25, left: left, top: vehicleExpenseTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(activityExpenseTxtField)
        activityExpenseTxtField.keyboardType = .numberPad
        activityExpenseTxtField.backgroundColor = .systemGray6
        activityExpenseTxtField.borderStyle = .roundedRect
        activityExpenseTxtField.allowsEditingTextAttributes = false
        activityExpenseTxtField.clearButtonMode = .never
        activityExpenseTxtField.inputView = UIView()
        activityExpenseTxtField.addGestureRecognizer(TRWidget.tapGesture(view: self, selector: #selector(notTappable), taps: 1))
        TRWidget.positionMaker(view: activityExpenseTxtField, height: 35, left: left, top: activityExpenseLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(roomRentExpenseLabel)
        TRWidget.positionMaker(view: roomRentExpenseLabel, width: view.frame.width - 20, height: 25, left: left, top: activityExpenseTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(roomRentExpenseTxtField)
        roomRentExpenseTxtField.keyboardType = .numberPad
        TRWidget.positionMaker(view: roomRentExpenseTxtField, height: 35, left: left, top: roomRentExpenseLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(foodExpenceLabel)
        TRWidget.positionMaker(view: foodExpenceLabel, width: view.frame.width - 20, height: 25, left: left, top: roomRentExpenseTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(foodExpenseTxtField)
        foodExpenseTxtField.keyboardType = .numberPad
        TRWidget.positionMaker(view: foodExpenseTxtField, height: 35, left: left, top: foodExpenceLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: foodExpenseTxtField.center.y + 25)
        toastTap = TRWidget.tapGesture(view: self, selector: #selector(enableEditMode), taps: 2)
        scrollView.addGestureRecognizer(toastTap)
    }
    static func getExpData(id : Int) -> TRExpenseData! {
        for exp in TRExpenseDataHandler.expenseData {
            if exp.tripID == id {
                return exp
            }
        }
        return nil
    }
    func loadData(id : Int) {
        if let d : TRExpenseData = TRExpenseVC.getExpData(id: id) {
            vehicleExpenseTxtField.text = String(Int(Double(d.vehicleExpense) * TRCurrencyTableVC.crntAmount))
            activityExpenseTxtField.text = String(Int(Double(d.activityExpense) * TRCurrencyTableVC.crntAmount))
            roomRentExpenseTxtField.text = String(Int(Double(d.roomRentExpense) * TRCurrencyTableVC.crntAmount))
            foodExpenseTxtField.text = String(Int(Double(d.foodExpense) * TRCurrencyTableVC.crntAmount))
        }
        
    }
    func getIntValue(string : String) -> Int{
        var val = Int(string) ?? 0
        val = Int(Double(val) / TRCurrencyTableVC.crntAmount)
        return val
    }
    func updateExp(index : Int) {
        TRExpenseDataHandler.updateExpense(expense: TRExpenseDataHandler.expenseData[index], vehicle: Int64(getIntValue(string: vehicleExpenseTxtField.text ?? "0")), activity: Int64(getIntValue(string: activityExpenseTxtField.text ?? "0")), roomRent: Int64(getIntValue(string: roomRentExpenseTxtField.text ?? "0")), foodExpense: Int64(getIntValue(string: foodExpenseTxtField.text ?? "0")))
    }
    func saveExp() {
        expenceData.addExpense(vehicle: Int64(getIntValue(string: vehicleExpenseTxtField.text ?? "0")), activity: Int64(getIntValue(string: activityExpenseTxtField.text ?? "0")), roomRent: Int64(getIntValue(string: roomRentExpenseTxtField.text ?? "0")), foodExpense: Int64(getIntValue(string: foodExpenseTxtField.text ?? "0")), tripId: Int64(TRLoginVC.tabBarVCs.travel.newTripInfoView.currentTripID))
    }
    func changeTextFieldProperty(bool : Bool) {
        vehicleExpenseTxtField.isUserInteractionEnabled = bool
        roomRentExpenseTxtField.isUserInteractionEnabled = bool
        foodExpenseTxtField.isUserInteractionEnabled = bool
        activityExpenseTxtField.isUserInteractionEnabled = bool
        isEditable = bool
        if !isDisplay {
            placeSaveButton()
        }
    }
    func setUserInteraction() {
        if vehicleExpenseTxtField.isUserInteractionEnabled == true {
            changeTextFieldProperty(bool: false)
        } else {
            changeTextFieldProperty(bool: true)
        }
    }
    func getCurrentExpense() -> Int {
        let f = Int(foodExpenseTxtField.text ?? "0") ?? 0
        let a = Int(activityExpenseTxtField.text ?? "0") ?? 0
        let r = Int(roomRentExpenseTxtField.text ?? "0") ?? 0
        let v = Int(vehicleExpenseTxtField.text ?? "0") ?? 0
        let exp = f + a + r + v
        return exp
    }
    deinit {
        print("expenseVC")
    }
    @objc func enableEditMode() {
        TRActions.showToast(message: "Enable Edit to Edit the Data's!!!", window: view.window!)
    }
    @objc func notTappable() {
        TRActions.showToast(message: "Not a Editable TextField!!! \nAmount added in Activity add Automatically", window: view.window!)
    }
    @objc func resignResponder() {
        foodExpenseTxtField.resignFirstResponder()
        roomRentExpenseTxtField.resignFirstResponder()
        vehicleExpenseTxtField.resignFirstResponder()
    }
}

extension TRExpenseVC : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        resignResponder()
    }
}
