//
//  LoginViewController.swift
//  Travel Register
//
//  Created by sunder-con870 on 07/02/22.
//

import UIKit

class TRLoginVC: UIViewController {
    
    //Variables
    ///Labels
    private let titleLabel = UILabel.loginLabel(text: "Travel Data Register")
    private let userIDLabel = UILabel.loginLabel(text: "User ID")
    private let passwordLabel = UILabel.loginLabel(text: "Password")
    private let confirmPasswordLabel = UILabel.loginLabel(text: "Confirm Password")
    private let infoLabel = UILabel.loginLabel(text: "New User ?")
    
    ///TextFields
    private let userIDTxtField = UITextField.loginTxtField(placeHolder: "Enter User ID")
    private let passwordTxtField = UITextField.loginTxtField(placeHolder: "Enter Password")
    private let confirmPasswordTxtField = UITextField.loginTxtField(placeHolder: "Re-Enter the Password")
    
    ///Views
    private let loginViewImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Travel")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private let loginView : UIView = {
        let view = UIView()
        UIBlurEffect.addBlur(view: view)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///Buttons
    private let mainButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentMainVC), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    private let switchButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSignInVC), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 15, y: 27, width: 45, height: 1.0)
        bottomLine.backgroundColor = UIColor.blue.cgColor
        button.layer.addSublayer(bottomLine)
        return button
    }()
    
    ///Bool
    private var hideSignInViews : Bool = true {
        didSet {
            if hideSignInViews == false {
                heightAnchor1.isActive = false
                heightAnchor2.isActive = true
            } else {
                heightAnchor2.isActive = false
                heightAnchor1.isActive = true
            }
        }
    }
    
    ///Datas
    private var heightAnchor1 : NSLayoutConstraint!
    private var heightAnchor2 : NSLayoutConstraint!
    static var tabBarVCs : TRTabBar = TRTabBar()
   
    //Functions
    ///Override Functions
        ///For stay in portrait
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    ///Functions
    func toggleLog_Signin(btn1Title : String, btn2Title : String, labelTxt : String, animatDuration : Double, alpha : CGFloat) {
        self.switchButton.setTitle(btn1Title, for: .normal)
        self.mainButton.setTitle(btn2Title, for: .normal)
        self.infoLabel.text = labelTxt
        UIView.animate(withDuration: animatDuration, animations: {
            self.confirmPasswordLabel.alpha = alpha
            self.confirmPasswordTxtField.alpha = alpha
            self.loadViewIfNeeded()
        })
    }
    func infoLabelConstraints() {
        infoLabel.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 15).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: loginView.centerXAnchor, constant: 18).isActive = true
    }
    func mainButtonConstraints() {
        mainButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -73).isActive = true
        mainButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        mainButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
    }
    func titleLabelConstraints() {
        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
            titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        } else {
            titleLabel.widthAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        }
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -15).isActive = true
    }
    func loginViewConstraints() {
        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
            loginView.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
            heightAnchor1 = loginView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5)
            heightAnchor2 = loginView.heightAnchor.constraint(equalToConstant: view.frame.height/2)
        } else {
            loginView.widthAnchor.constraint(equalToConstant: view.frame.height - 20).isActive = true
            heightAnchor1 = loginView.heightAnchor.constraint(equalToConstant: view.frame.width/2.5)
            heightAnchor2 = loginView.heightAnchor.constraint(equalToConstant: view.frame.width/2)
        }
        loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heightAnchor1.isActive = true
    }
    func positionMaker(view : UIView, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, right : NSLayoutAnchor<NSLayoutXAxisAnchor>, top : NSLayoutAnchor<NSLayoutYAxisAnchor>, topCon : CGFloat) {
        view.leftAnchor.constraint(equalTo: left,constant: 20).isActive = true
        view.rightAnchor.constraint(equalTo: right, constant: -20).isActive = true
        view.topAnchor.constraint(equalTo: top,constant: topCon).isActive = true
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    func configureVC() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: nil)
        titleLabel.textAlignment = .center
        view.backgroundColor = .white
        view.addSubview(loginViewImage)
        TRWidget.positionMaker(view: loginViewImage, left: view.leftAnchor, right: view.rightAnchor, top: view.topAnchor, bottom: view.bottomAnchor, leftCon: 0, righCon: 0, topCon: 0, bottomCon: 0)
        loginViewImage.addSubview(loginView)
        loginViewConstraints()
        view.addSubview(titleLabel)
        titleLabelConstraints()
        loginView.addSubview(userIDTxtField)
        positionMaker(view: userIDTxtField, left: loginView.leftAnchor, right: loginView.rightAnchor, top: loginView.topAnchor,topCon: 60)
        loginView.addSubview(passwordTxtField)
        positionMaker(view: passwordTxtField, left: loginView.leftAnchor, right: loginView.rightAnchor, top: loginView.topAnchor, topCon: 160)
        loginView.addSubview(userIDLabel)
        positionMaker(view: userIDLabel, left: loginView.leftAnchor, right: loginView.rightAnchor, top: loginView.topAnchor, topCon: 20)
        loginView.addSubview(passwordLabel)
        positionMaker(view: passwordLabel, left: loginView.leftAnchor, right: loginView.rightAnchor, top: loginView.topAnchor, topCon: 120)
        loginView.addSubview(mainButton)
        mainButtonConstraints()
        loginView.addSubview(switchButton)
        TRWidget.positionMaker(view: switchButton, width: 75, height: 35, left: loginView.centerXAnchor, top: mainButton.bottomAnchor, leftCon: 10, topCon: 13)
        loginView.addSubview(infoLabel)
        infoLabelConstraints()
        view.addSubview(confirmPasswordLabel)
        confirmPasswordLabel.alpha = 0
        positionMaker(view: confirmPasswordLabel, left: loginView.leftAnchor, right: loginView.rightAnchor, top: loginView.topAnchor, topCon: 220)
        confirmPasswordTxtField.alpha = 0
        view.addSubview(confirmPasswordTxtField)
        positionMaker(view: confirmPasswordTxtField, left: loginView.leftAnchor, right: loginView.rightAnchor, top: loginView.topAnchor, topCon: 260)
    }
    
    ///Static Functions
    static func loadDatas() {
        TRTripDataHandler.reteriveAllTrips()
        TRActivityDataHandler.reteriveAllActivities()
        TRExpenseDataHandler.reteriveAllExpenses()
        TRFriendDataHandeler.reteriveAllFriends()
        print("\(TRTripDataHandler.tripData.count)\n\(TRActivityDataHandler.activityData.count)\n\(TRExpenseDataHandler.expenseData.count)\n\(TRFriendDataHandeler.friendData.count)\n")
//        RestoreData.deleteData()
    }
    
    ///Objc Functions
    @objc func presentMainVC() {
        TRDataTool.userDefault.setValue(true, forKey: "Bool")
        TRLoginVC.loadDatas()
        present(TRLoginVC.tabBarVCs.tabBar, animated: true, completion: nil)
    }
    @objc func presentSignInVC() {
        DispatchQueue.main.async {
            if self.hideSignInViews == false {
                self.toggleLog_Signin(btn1Title: "Login", btn2Title: "SignUp", labelTxt: "Exist User?", animatDuration: 0.5, alpha: 1)
            } else {
                self.toggleLog_Signin(btn1Title: "SignUp", btn2Title: "Login", labelTxt: "New User ?", animatDuration: 0.1, alpha: 0)
            }
        }
        hideSignInViews.toggle()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
