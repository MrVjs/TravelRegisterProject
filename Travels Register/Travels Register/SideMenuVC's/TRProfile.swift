//
//  Profile.swift
//  Travel Register
//
//  Created by sunder-con870 on 23/02/22.
//

import UIKit

class TRProfile : UIViewController {
    
    private let profileImage : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .systemGray6
        img.layer.cornerRadius = 37
        img.image = UIImage(systemName: "person.crop.circle")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let userName : UILabel = {
        let lbl = UILabel()
        lbl.text = "User Name"
        lbl.font = .systemFont(ofSize: 25, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let userId : UILabel = {
        let lbl = UILabel()
        lbl.text = "ID : User@123"
        lbl.font = .systemFont(ofSize: 18, weight: .thin)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    deinit {
        print("called profile")
    }
    
    private func configureVC() {
        title = "Profile"
        view.addSubview(profileImage)
        TRWidget.positionMaker(view: profileImage, width: view.frame.width/4, height: view.frame.width/4, left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, leftCon: 20, topCon: 20)
        view.addSubview(userName)
        TRWidget.positionMaker(view: userName, width: view.frame.width - profileImage.frame.width - 40, height: 40, left: profileImage.rightAnchor, top: profileImage.topAnchor, leftCon: 20, topCon: profileImage.frame.width/2 + 15)
        view.addSubview(userId)
        TRWidget.positionMaker(view: userId, width: view.frame.width - profileImage.frame.width - 40, height: 35, left: profileImage.rightAnchor, top: userName.bottomAnchor, leftCon: 20, topCon: 0)
    }
}
