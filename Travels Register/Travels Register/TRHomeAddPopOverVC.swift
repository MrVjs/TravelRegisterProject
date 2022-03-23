//
//  PopOverViewController.swift
//  Travel Register
//
//  Created by sunder-con870 on 02/02/22.
//

import UIKit

class TRHomeAddPopOverVC : UIViewController {
    private var v1 : UIView!
    private var v2 : UIView!
    private var v3 : UIView!
    private let stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.backgroundColor = .gray
        sv.spacing = 1
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.layer.cornerRadius = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    @objc func tripAddTapped() {
        dismiss(animated: true, completion: nil)
        TRLoginVC.tabBarVCs.travel.addNewTrip(crntView: TRLoginVC.tabBarVCs.home)
    }
    @objc func friendAddTapped() {
        dismiss(animated: true, completion: nil)
        TRLoginVC.tabBarVCs.friends.addNewFriend(presentView: TRLoginVC.tabBarVCs.home)
    }
    @objc func activityAddTapped() {
        dismiss(animated: true, completion: nil)
        TRLoginVC.tabBarVCs.activity.addNewActivity(crntView: TRLoginVC.tabBarVCs.home)
    }
    private var addTripTapGesture : UITapGestureRecognizer!
    private var addFriendTapGesture : UITapGestureRecognizer!
    private var addActivityTapGesture : UITapGestureRecognizer!
    func stackViewConstraints() {
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.preferredContentSize = CGSize(width: 230, height: 70)
        configureVC()
    }
    func configureVC() {
        v1 = UIView()
        v2 = UIView()
        v3 = UIView()
        stackView.addArrangedSubview(v1)
        stackView.addArrangedSubview(v2)
        stackView.addArrangedSubview(v3)
        let addTrip = labelCreator(name: "Travel")
        let addFriend = labelCreator(name: "Friend")
        let addActiviy = labelCreator(name: "Activity")
        let tripImg = imageLoader(name : "globe.asia.australia")
        let frndImg = imageLoader(name: "person.2.circle")
        let actimg = imageLoader(name: "figure.walk.circle")
        v1.addSubview(addTrip)
        v1.addSubview(tripImg)
        v1.backgroundColor = .systemBackground
        v2.addSubview(addFriend)
        v2.addSubview(frndImg)
        v2.backgroundColor = .systemBackground
        v3.addSubview(addActiviy)
        v3.addSubview(actimg)
        v3.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackViewConstraints()
        addTripTapGesture = TRWidget.tapGesture(view: self, selector: #selector(tripAddTapped), taps: 1)
        addFriendTapGesture = TRWidget.tapGesture(view: self, selector: #selector(friendAddTapped), taps: 1)
        addActivityTapGesture = TRWidget.tapGesture(view: self, selector: #selector(activityAddTapped), taps: 1)
        v1.addGestureRecognizer(addTripTapGesture)
        v2.addGestureRecognizer(addFriendTapGesture)
        v3.addGestureRecognizer(addActivityTapGesture)
    }
    func imageLoader(name : String) -> UIImageView {
        let img = UIImageView(frame: CGRect(x: 22.5, y: 5, width: 30, height: 30))
        img.image = UIImage(systemName: name)
        return img
    }
    func labelCreator(name : String) -> UILabel{
        let lbl = UILabel(frame: CGRect(x: 7, y: 35, width: 60 , height: 30))
        lbl.text = name
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }
}
