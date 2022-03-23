//
//  FriendsInfoView.swift
//  Travel Register
//
//  Created by sunder-con870 on 15/02/22.
//

import UIKit

class TRFriendInfoVC : UIViewController {
    
    //Variables
    ///Datas
    private var tripListVC : TRTripListVC!
    private var friendData = TRFriendDataHandeler()
    private var selectedFriendIndex : Int!
    var currentTripID : Int!
    var selectedTripIndex : Int!

    ///Bools
    private var isPhooneNoEmpty : Bool = false
    private var isContextIsEditable : Bool!
    
    ///Gestures
    private var tapGesture : UITapGestureRecognizer!
    private var toastTap : UITapGestureRecognizer!
    
    ///Labels
    private let selectTripLabel = TRWidget.label(name: "Select a Trip To add Friend:")
    private let friendNameLabel = TRWidget.label(name: "Friend Name:")
    private let occuoationLabel = TRWidget.label(name: "Friend Occupation:")
    private let meetLocationLabel = TRWidget.label(name: "Meet Location:")
    private let phoneNoLabel = TRWidget.label(name: "Phone No:")
    
    ///TextFields
    let tripTextField = TRWidget.textField(placeHolder: "Select a Trip", tintColor: .clear)
    let nameTxtField = TRWidget.textField(placeHolder: "Enter Friend Name", tintColor: .systemGray)
    let occupationTextField = TRWidget.textField(placeHolder: "Enter Friend's Occupation", tintColor: .systemGray)
    let meetLocationTxtField = TRWidget.textField(placeHolder: "Enter the meet location", tintColor: .systemGray)
    let phoneNoTxtField = TRWidget.textField(placeHolder: "Enter Ph No", tintColor: .systemGray)
    
    ///Views
    private var scrollView : UIScrollView!
    
    ///Buttons
    private let callButton : UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.addTarget(self, action: #selector(triggerCall), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    ///Functions
    //Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: phoneNoTxtField.center.y + 25)
    }
    
    //Functions
    func changeTextFieldProperty(bool :Bool) {
        nameTxtField.isUserInteractionEnabled = bool
        occupationTextField.isUserInteractionEnabled = bool
        meetLocationTxtField.isUserInteractionEnabled = bool
        phoneNoTxtField.isUserInteractionEnabled = bool
        if !isPhooneNoEmpty {
            callButton.isHidden.toggle()
        }
    }
    func changeUserInteractable() {
        if nameTxtField.isUserInteractionEnabled == true {
            changeTextFieldProperty(bool: false)
            tripTextField.isEnabled = false
        } else {
            changeTextFieldProperty(bool: true)
        }
    }
    func asAddFriendView(viewToPresent : UIViewController) {
        callButton.isHidden = true
        TRActions.addNew(newView: self, title: "Add Friend Info", view: self, saveSelector: #selector(saveButtonTrigger), backSelector: #selector(backTapped),presentView: viewToPresent)
    }
    func asDisplayFriendView(selectedIndex : Int, selfView : UIViewController, friend : TRFriendsData) {
        selectedFriendIndex = selectedIndex
        isContextIsEditable = false
        changeUserInteractable()
        currentTripID = Int(friend.tripID)
        loadData(friend : friend)
        setTripTextFieldsText()
        title = "Friend Info"
        toastTap = TRWidget.tapGesture(view: self, selector: #selector(enableEditMode), taps: 1)
        TRActions.asDisplayView(view: self, deleteSelector: #selector(deleteFriendData), editSelector: #selector(makeEditable), self: selfView)
        scrollView.addGestureRecognizer(toastTap)
    }
    func loadData(friend : TRFriendsData) {
        nameTxtField.text = friend.friendName
        occupationTextField.text = friend.occupation?.count != 0 ? friend.occupation : " "
        meetLocationTxtField.text = friend.meetPlace?.count != 0 ? friend.meetPlace : " "
        if let no = friend.phoneNo {
            phoneNoTxtField.text = no
            if no.count == 0 {
                isPhooneNoEmpty = true
                callButton.isHidden = true
                phoneNoTxtField.text = " "
            }
        } else {
            phoneNoTxtField.text = " "
        }
    }
    func setTripTextFieldsText() {
        selectTripLabel.text = "Friend Added to the Trip of:"
        let fetch = TRTripData.fetchRequest()
        let predicate = NSPredicate(format: "tripID CONTAINS '\(currentTripID!)'")
        fetch.predicate = predicate
        let trip = try! TRDataTool.context.fetch(fetch)
        tripTextField.text = "\((trip.first!.getStartDate())) at \(trip.first!.getPlaceName())"
    }
    func asTripViewsAddFriendView(tripIndex : Int) {
        callButton.isHidden = true
        tripTextField.isEnabled = false
        currentTripID = tripIndex
        setTripTextFieldsText()
        navigationItem.rightBarButtonItem?.isEnabled = true
        nameTxtField.becomeFirstResponder()
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
        nameTxtField.delegate = self
        occupationTextField.delegate = self
        meetLocationTxtField.delegate = self
        phoneNoTxtField.delegate = self
        phoneNoTxtField.keyboardType = .asciiCapableNumberPad
        tapGesture = TRWidget.tapGesture(view: self, selector: #selector(presentTripList), taps: 1)
        let width = view.frame.width
        let left = scrollView.safeAreaLayoutGuide.leftAnchor
        let right = scrollView.safeAreaLayoutGuide.rightAnchor
        view.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
        scrollView.addSubview(selectTripLabel)
        selectTripLabel.font = .systemFont(ofSize: 20, weight: .thin)
        TRWidget.positionMaker(view: selectTripLabel, width: width-20, height: 25, left: left, top: scrollView.topAnchor, leftCon: 10, topCon: 20)
        scrollView.addSubview(tripTextField)
        TRWidget.positionMaker(view: tripTextField, height: 40, left: left, top: selectTripLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        tripTextField.borderStyle = .roundedRect
        tripTextField.backgroundColor = .lightGray.withAlphaComponent(0.2)
        if TRTripDataHandler.tripData.count == 0 {
            tripTextField.isUserInteractionEnabled = false
            tripTextField.text = "No Trip's Found!!!"
        } else {
            tripTextField.isUserInteractionEnabled = true
        }
        tripTextField.addGestureRecognizer(tapGesture)
        scrollView.addSubview(friendNameLabel)
        TRWidget.positionMaker(view: friendNameLabel, width: width-20, height: 25, left: left, top: tripTextField.bottomAnchor, leftCon: 10, topCon: 20)
        scrollView.addSubview(nameTxtField)
        TRWidget.positionMaker(view: nameTxtField, height: 35, left: left, top: friendNameLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(occuoationLabel)
        TRWidget.positionMaker(view: occuoationLabel, width: width-20, height: 25, left: left, top: nameTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(occupationTextField)
        TRWidget.positionMaker(view: occupationTextField, height: 35, left: left, top: occuoationLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(meetLocationLabel)
        TRWidget.positionMaker(view: meetLocationLabel, width: width-20, height: 25, left: left, top: occupationTextField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(meetLocationTxtField)
        TRWidget.positionMaker(view: meetLocationTxtField, height: 35, left: left, top: meetLocationLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        scrollView.addSubview(phoneNoLabel)
        TRWidget.positionMaker(view: phoneNoLabel, width: width-20, height: 25, left: left, top: meetLocationTxtField.bottomAnchor, leftCon: 10, topCon: 15)
        scrollView.addSubview(phoneNoTxtField)
        phoneNoTxtField.tag = 1
        TRWidget.positionMaker(view: phoneNoTxtField, height: 35, left: left, top: phoneNoLabel.bottomAnchor, right: right, leftCon: 10, topCon: 0, rightCon: -10)
        view.addSubview(callButton)
        TRWidget.positionMaker(view: callButton, right: right, bottom: phoneNoTxtField.topAnchor, width: 40, height: 25, rightCon: 0, bottomCon: -5)
        scrollView.delegate = self
    }
    
    //Static Functions
    static func deleteFriend(friend : TRFriendsData, isFromSearch : Bool = false) {
        TRFriendDataHandeler.deleteFriend(item: friend)
        if isFromSearch == false {
            TRLoginVC.tabBarVCs.friends.loadDatatoView()
        }
        TRLoginVC.tabBarVCs.travel.newTripInfoView?.loadTableViewData()
    }
    
    //Objc Functions
    @objc func triggerCall() {
        let number = phoneNoTxtField.text
        if let url = URL(string: "tel://\(number!)") {
             UIApplication.shared.open(url)
         }
    }
    
    @objc func presentTripList() {
        tripListVC = TRTripListVC()
        tripListVC.currentFInfoView = self
        let navi = UINavigationController(rootViewController: tripListVC)
        present(navi, animated: true, completion: nil)
    }
    @objc func dismissKeyBoard() {
        nameTxtField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
        meetLocationTxtField.resignFirstResponder()
        phoneNoTxtField.resignFirstResponder()
    }
    @objc func saveChanges() {
        makeEditable()
        friendData.updateFriend(friend: TRFriendDataHandeler.friendData[selectedFriendIndex], friendName: nameTxtField.text!, occupation: occupationTextField.text!, meetPlace: meetLocationTxtField.text!, phoneNo: phoneNoTxtField.text!)
        TRLoginVC.tabBarVCs.friends.loadDatatoView()
        TRLoginVC.tabBarVCs.travel.newTripInfoView?.friendsVC?.tableView.reloadData()
    }
    @objc func cancelButtonTapped() {
        makeEditable()
    }
    @objc func makeEditable() {
        if isContextIsEditable == false {
            isContextIsEditable = true
            scrollView?.removeGestureRecognizer(toastTap)
            TRActions.enableEdit(view: self, saveSelector: #selector(saveChanges), cancelSelector: #selector(cancelButtonTapped),self: self)
            changeUserInteractable()
            nameTxtField.becomeFirstResponder()
        } else {
            isContextIsEditable = false
            scrollView?.addGestureRecognizer(toastTap)
            TRActions.disableEdit(view: self, delectSelector: #selector(deleteFriendData), self: self)
            changeUserInteractable()
        }
    }
    @objc func deleteFriendData() {
        let yes = UIAlertAction(title: "Yes", style: .destructive) { action in
            TRFriendInfoVC.deleteFriend(friend: TRFriendDataHandeler.friendData[self.selectedFriendIndex])
            self.navigationController?.popViewController(animated: true)
        }
        TRActions.delete(currentTripIndex: currentTripID, selectedIndex: selectedFriendIndex, yes: yes, view: self)
    }
    @objc func backTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func saveButtonTrigger() {
        friendData.addFriend(friendName: nameTxtField.text!, occupation: occupationTextField.text!, meetPlace: meetLocationTxtField.text!, phoneNo: phoneNoTxtField.text!, tripID: Int64(currentTripID))
        _ = TRLoginVC.tabBarVCs.travel.newTripInfoView?.friendsVC.reloadData()
        TRLoginVC.tabBarVCs.travel.newTripInfoView?.loadTableViewData()
        TRLoginVC.tabBarVCs.friends.loadDatatoView()
        TRLoginVC.tabBarVCs.home.update()
        backTapped()
    }
    @objc func enableEditMode() {
        TRActions.showToast(message: "Enable Edit to Edit the Data's!!!", window: view.window!)
    }
}

extension TRFriendInfoVC : UITextFieldDelegate, UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchTxtFieldAsResponder(textField: textField)
        return true
    }
    func switchTxtFieldAsResponder(textField : UITextField) {
        switch textField {
        case self.nameTxtField:
            self.occupationTextField.becomeFirstResponder()
        case self.occupationTextField:
            self.meetLocationTxtField.becomeFirstResponder()
        case self.meetLocationTxtField:
            self.phoneNoTxtField.becomeFirstResponder()
        default:
            return
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            return range.location < 12
        }
        return range.location < 30
    }
}
