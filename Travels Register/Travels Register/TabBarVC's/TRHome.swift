//
//  TabBarHome.swift
//  Travel Register
//
//  Created by sunder-con870 on 31/01/22.
//

import UIKit

class TRHome : UIViewController {
    
    //Variables
    ///Labels
    lazy private var travelInfoLabel = labelCreator(text: " Travel Info ", size: 20, weight: .bold, noOfLines: 1)
    lazy private var noOfTravelLabel = labelCreator(text: "Total No of Tirp's", size: 20, weight: .thin, noOfLines: 2)
    lazy private var noOfTravels = labelCreator(text: "\(TRTripDataHandler.getNoOfTrip())", size: 39, weight: .regular, noOfLines: 1)
    lazy private var lastTravelLocationLabel = labelCreator(text: "Last Trip Location", size: 20, weight: .thin, noOfLines: 2)
    lazy private var lastTripLocation = labelCreator(text: "\(TRTripDataHandler.getLastTripLocation())", size: 39, weight: .regular, noOfLines: 1)
    lazy private var expenseInfoLabel = labelCreator(text: " Expense Info ", size: 20, weight: .bold, noOfLines: 1)
    lazy private var totalTripExpenseLabel = labelCreator(text: "Total Trip Expense's", size: 20, weight: .thin, noOfLines: 2)
    lazy private var totalTripExpense = labelCreator(text: "₹\(TRExpenseDataHandler.getTotalExpenses())", size: 39, weight: .regular, noOfLines: 1)
    lazy private var lastTripExpenseLabel = labelCreator(text: "Last Trip Expense", size: 20, weight: .thin, noOfLines: 2)
    lazy private var lastTripExpense = labelCreator(text: "₹\(TRExpenseDataHandler.getLastExpense())", size: 39, weight: .regular, noOfLines: 1)
    lazy private var otherInfoLabel = labelCreator(text: " Other Info's ", size: 20, weight: .bold, noOfLines: 1)
    lazy private var totalFriendsLabel = labelCreator(text: "Total No of Friend's", size: 20, weight: .thin, noOfLines: 2)
    lazy private var totalFriends = labelCreator(text: "\(TRFriendDataHandeler.getNoofFriends())", size: 39, weight: .regular, noOfLines: 1)
    lazy private var totalActivitiesLabel = labelCreator(text: "Total No Of Activities", size: 20, weight: .thin, noOfLines: 2)
    lazy private var totalActivities = labelCreator(text: "\(TRActivityDataHandler.getNoOfActivities())", size: 39, weight: .regular, noOfLines: 1)
    
    ///Views
    private let view1 = UIView.view()
    private let view2 = UIView.view()
    private let view3 = UIView.view()
    private var swipeView : UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .gray.withAlphaComponent(0.07)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var sideMenu : UIView = {
        let view = UIView()
        view.addSubview(UILabel())
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.layer.cornerRadius = 10
        sv.autoresizingMask = .flexibleHeight
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    ///Anchors
    private var widthAnchor1 : NSLayoutConstraint!
    private var widthAnchor2 : NSLayoutConstraint!
    private var swipeViewW1 : NSLayoutConstraint!
    private var swipeViewW2 : NSLayoutConstraint!
    
    ///Booleans
    private var hideSideMenu = true
    
    ///Buttons
    private let addButton = UIButton().bottomButton(type: "plus")
    
    //Functions
    ///Override Functions
    override func viewDidLoad() {
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            stackView.axis = .vertical
            rotationChanges(bool: false)
        } else {
            stackView.axis = .horizontal
            rotationChanges(bool: true)
        }
        super.viewDidLoad()
        configureVC()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if stackView.axis == .vertical && UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
            rotationChanges(bool: true)
        } else if stackView.axis == .horizontal && UIDevice.current.orientation.isPortrait {
            stackView.axis = .vertical
            rotationChanges(bool: false)
        }
    }
    
    ///Normal Functions
    func labelCreator(text : String, size : CGFloat, weight : UIFont.Weight, noOfLines : Int) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.font = .systemFont(ofSize: size, weight: weight)
        lbl.textAlignment = .center
        lbl.numberOfLines = noOfLines
        return lbl
    }
    func swipeViewConstraints() {
        swipeView.leftAnchor.constraint(equalTo: sideMenu.rightAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swipeView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        swipeViewW1 = swipeView.widthAnchor.constraint(equalToConstant: 0)
        swipeViewW2 = swipeView.widthAnchor.constraint(equalToConstant: view.frame.height)
        swipeViewW1.isActive = true
    }
    func sideMenuConstraints() {
        sideMenu.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        sideMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sideMenu.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        widthAnchor1 = sideMenu.widthAnchor.constraint(equalToConstant: 0)
        widthAnchor2 = sideMenu.widthAnchor.constraint(equalToConstant: view.frame.width/2 )
        widthAnchor1.isActive = true
    }
    func tableViewCreator(view : UIViewController) {
        let menuSideTable = TRSideMenu()
        menuSideTable.isScrollEnabled = false
        menuSideTable.currentVC = view
        sideMenu.addSubview(menuSideTable)
        menuSideTable.translatesAutoresizingMaskIntoConstraints = false
        TRWidget.positionMaker(view: menuSideTable, left: sideMenu.leftAnchor, right: sideMenu.rightAnchor, top: view.view.safeAreaLayoutGuide.topAnchor, bottom: view.view.safeAreaLayoutGuide.bottomAnchor, leftCon: 0, righCon: 0, topCon: 0, bottomCon: 0)
        menuSideTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        menuSideTable.delegate = menuSideTable.self
        menuSideTable.dataSource = menuSideTable.self
    }
    func rotationChanges(bool : Bool) {
        noOfTravels.adjustsFontSizeToFitWidth = bool
        totalTripExpense.adjustsFontSizeToFitWidth = bool
        lastTripExpense.adjustsFontSizeToFitWidth = bool
        lastTripLocation.numberOfLines = 2
    }
    func stackViewBuilder(currentStack : UIStackView,topLabel : UILabel, view : UIView, l1 : UILabel, l2 : UILabel, l3 : UILabel, l4 : UILabel) {
        currentStack.frame = CGRect(x: 0, y: topLabel.frame.height, width: view.frame.width, height: view1.frame.height - (topLabel.frame.height)*3)
        currentStack.distribution = .fillEqually
        currentStack.axis = .horizontal
        currentStack.autoresizingMask = .flexibleWidth
        view.addSubview(currentStack)
        subStack(l1: l1, l2: l2, currentStack: currentStack)
        subStack(l1: l3, l2: l4, currentStack: currentStack)
    }
    func subStack(l1 : UILabel, l2 : UILabel, currentStack : UIStackView){
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        currentStack.addArrangedSubview(stack)
        stack.addArrangedSubview(l1)
        stack.addArrangedSubview(l2)
    }
    func addSwipeRightPanGesture(_ view : UIView) {
        let swipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(menuHideGesture(_:)))
        swipe.edges = .left
        view.addGestureRecognizer(swipe)
    }
    func addSwipe(view : UIView){
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(menuTriggerGesture(_:)))
        tap.direction = .left
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    func sideMenuToggler(title : String, bool : Bool, colour : UIColor) {
        hideSideMenu.toggle()
        self.title = title
        navigationItem.rightBarButtonItem?.isEnabled = bool
        addButton.backgroundColor = colour
    }
    func swipeViewTrigger() {
        var delay : CGFloat!
        if hideSideMenu == false {
            swipeViewW1.isActive = false
            swipeViewW2.isActive = true
            delay = 0.3
        } else {
            swipeViewW2.isActive = false
            swipeViewW1.isActive = true
            delay = 0
        }
        UIView.animate(withDuration: 0, delay: delay, options: .curveLinear, animations: { self.view.layoutIfNeeded()})
    }
    func configureVC() {
        update()
        let mainStack1 = UIStackView()
        let mainStack2 = UIStackView()
        let mainStack3 = UIStackView()
        view.backgroundColor = .systemBackground
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.menu.rawValue), selector: #selector(sideMenuTrigger), view: self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: #selector(goBack))
        addSwipeRightPanGesture(view)
        view.addSubview(stackView)
        TRWidget.positionMaker(view: stackView, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leftCon: 10, righCon: -10, topCon: 10, bottomCon: -20)
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.layoutIfNeeded()
        //// First UIView
        travelInfoLabel.autoresizingMask = .flexibleWidth
        view1.addSubview(travelInfoLabel)
        view1.backgroundColor = .systemBackground
        lastTripLocation.adjustsFontSizeToFitWidth = true
        travelInfoLabel.frame = CGRect(x: 0, y: 0, width: view1.frame.width, height: 40)
        stackViewBuilder(currentStack: mainStack1, topLabel: travelInfoLabel, view: view1, l1: noOfTravelLabel, l2: noOfTravels, l3: lastTravelLocationLabel, l4: lastTripLocation)
        let travelsTap = TRWidget.tapGesture(view: self, selector: #selector(showTravelsView), taps: 1)
        noOfTravels.addGestureRecognizer(travelsTap)
        noOfTravels.isUserInteractionEnabled = true
        noOfTravels.textColor = .systemBlue.withAlphaComponent(0.7)
        let lastTripTap = TRWidget.tapGesture(view: self, selector: #selector(showLastTrip), taps: 1)
        lastTripLocation.addGestureRecognizer(lastTripTap)
        lastTripLocation.isUserInteractionEnabled = true
        lastTripLocation.textColor = .systemBlue.withAlphaComponent(0.7)
        //// Second UIView
        view2.backgroundColor = .systemBackground
        expenseInfoLabel.frame = CGRect(x: 0, y: 0, width: view2.frame.width, height: 40)
        view2.addSubview(expenseInfoLabel)
        expenseInfoLabel.autoresizingMask = .flexibleWidth
        stackViewBuilder(currentStack: mainStack2, topLabel: expenseInfoLabel, view: view2, l1: totalTripExpenseLabel, l2: totalTripExpense, l3: lastTripExpenseLabel, l4: lastTripExpense)
        let lastExpTap = TRWidget.tapGesture(view: self, selector: #selector(showLastExpense),taps: 1)
        lastTripExpense.addGestureRecognizer(lastExpTap)
        lastTripExpense.isUserInteractionEnabled = true
        lastTripExpense.textColor = .systemBlue.withAlphaComponent(0.7)
        let allExpenseTap = TRWidget.tapGesture(view: self, selector: #selector(showAllExpense), taps: 1)
        totalTripExpense.addGestureRecognizer(allExpenseTap)
        totalTripExpense.isUserInteractionEnabled = true
        totalTripExpense.textColor = .systemBlue.withAlphaComponent(0.7)
        //// Thrid UIView
        view3.backgroundColor = .systemBackground
        otherInfoLabel.frame = CGRect(x: 0, y: 0, width: view1.frame.width, height: 40)
        view3.addSubview(otherInfoLabel)
        otherInfoLabel.autoresizingMask = .flexibleWidth
        stackViewBuilder(currentStack: mainStack3, topLabel: otherInfoLabel, view: view3, l1: totalFriendsLabel, l2: totalFriends, l3: totalActivitiesLabel, l4: totalActivities)
        totalActivities.textColor = .systemBlue.withAlphaComponent(0.7)
        let tap = TRWidget.tapGesture(view: self, selector: #selector(showActivitiesView), taps: 1)
        totalActivities.addGestureRecognizer(tap)
        totalActivities.isUserInteractionEnabled = true
        let friendsTap = TRWidget.tapGesture(view: self, selector: #selector(showFriendsView), taps: 1)
        totalFriends.addGestureRecognizer(friendsTap)
        totalFriends.isUserInteractionEnabled = true
        totalFriends.textColor = .systemBlue.withAlphaComponent(0.7)
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addNewTrip), for: .touchUpInside)
        addButton.bottomButtonConstraints(button: addButton, view: view)
        view.addSubview(sideMenu)
        sideMenuConstraints()
        view.addSubview(swipeView)
        swipeViewConstraints()
        addSwipe(view: swipeView)
        swipeView.addGestureRecognizer(TRWidget.tapGesture(view: self, selector: #selector(sideMenuTrigger), taps: 1))
        tableViewCreator(view: self)
    }
    
    ///Objc Functions
    @objc func addNewTrip() {
        let vc = TRHomeAddPopOverVC()
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.sourceView = addButton
        vc.popoverPresentationController?.permittedArrowDirections = .down
        vc.popoverPresentationController?.delegate = self
        present(vc, animated: true, completion: nil)
    }
    @objc func update() {
        var totalExp : Double!
        var lastExp : Double!
        if let amount = TRDataTool.userDefault.value(forKey: "amount") as? Double {
            totalExp = (Double(TRExpenseDataHandler.getTotalExpenses())  * amount )
            lastExp = (Double(TRExpenseDataHandler.getLastExpense())  * amount )
            TRCurrencyTableVC.crntAmount = amount
        }
        noOfTravels.text = "\(TRTripDataHandler.getNoOfTrip())"
        lastTripLocation.text = "\(TRTripDataHandler.getLastTripLocation())"
        totalTripExpense.text = "\(TRCurrencyTableVC.getCurrencySymbol())\(Int(totalExp ?? 0))"
        lastTripExpense.text = "\(TRCurrencyTableVC.getCurrencySymbol())\(Int(lastExp ?? 0))"
        totalFriends.text = "\(TRFriendDataHandeler.getNoofFriends())"
        totalActivities.text = "\(TRActivityDataHandler.getNoOfActivities())"
    }
    @objc func sideMenuTrigger() {
        if hideSideMenu == true {
            sideMenuToggler(title: "Menu", bool: false, colour: .systemGray4)
            widthAnchor1.isActive = false
            widthAnchor2.isActive = true
        } else {
            sideMenuToggler(title: "Home", bool: true, colour: .systemBlue)
            widthAnchor2.isActive = false
            widthAnchor1.isActive = true
            TRLoginVC.tabBarVCs.home.update()
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
        self.swipeViewTrigger()
    }
    @objc func goBack() {
        let alert = UIAlertController(title: nil, message: "Do You Want to LogOut?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { action in
            TRDataTool.userDefault.setValue(false, forKey: "Bool")
            self.dismiss(animated: true, completion: nil)
        }
        let no = UIAlertAction(title: "No", style: .cancel) { action in
        }
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func backTapped() {
        dismiss(animated: true, completion: nil)
        TRLoginVC.tabBarVCs.home.update()
    }
    @objc func menuHideGesture(_ gesture : UIGestureRecognizer) {
        if gesture.state == .began {
            sideMenuTrigger()
        }
    }
    @objc func menuTriggerGesture(_ gesture : UISwipeGestureRecognizer) {
            sideMenuTrigger()
    }
    @objc func showAllExpense() {
        let vc = TRExpenseListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func showLastExpense() {
        if let id = TRTripDataHandler.tripData.last?.tripID {
            let vc = TRExpenseVC()
            vc.isDisplay = true
            vc.loadData(id: Int(id))
            vc.setUserInteraction()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            TRActions.showToast(message: "No Trip's Added!!!", window: view.window!)
        }
    }
    @objc func showLastTrip() {
        if TRTripDataHandler.tripData.last == nil {
            TRActions.showToast(message: "No Trip's Added!!!", window: view.window!)
        } else {
            let vc = TRTripInfoVC()
            vc.asDisplayTripView(selectedIndex: TRTripDataHandler.getNoOfTrip() - 1, selfView: self, trip: TRTripDataHandler.tripData.last!)
        }
    }
    @objc func showTravelsView() {
        tabBarController?.selectedViewController = tabBarController?.viewControllers![1]
    }
    @objc func showFriendsView() {
        tabBarController?.selectedViewController = tabBarController?.viewControllers![2]
    }
    @objc func showActivitiesView() {
        tabBarController?.selectedViewController = tabBarController?.viewControllers![3]
    }
}

extension TRHome : UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
        }
}
