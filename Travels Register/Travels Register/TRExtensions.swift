//
//  AddButton.swift
//  Travel Register
//
//  Created by sunder-con870 on 03/02/22.
//

import UIKit

extension UIBlurEffect {
    static func addBlur(view : UIView) {
        let bev = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        bev.frame = view.bounds
        bev.layer.cornerRadius = 10
        bev.clipsToBounds = true
        view.addSubview(bev)
        bev.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

extension UILabel {
    static func loginLabel(text : String) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
}

extension UITextField {
    static func loginTxtField(placeHolder : String) -> UITextField {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.placeholder = placeHolder
        txt.layer.cornerRadius = 5
        txt.layer.shadowColor = UIColor.gray.cgColor
        txt.layer.shadowOpacity = 0.5
        txt.layer.shadowOffset = .zero
        txt.layer.shadowRadius = 10
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }
}

extension UIButton {
    func bottomButton(type : String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: type), for: .normal)
        btn.backgroundColor = .systemBlue
        btn.tintColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = .zero
        btn.layer.shadowRadius = 10
        btn.layer.masksToBounds = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    func bottomButtonConstraints(button : UIButton, view : UIView) {
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}

extension UIBarButtonItem {
    static func button(image : UIImage? = nil, name : String? = nil, selector : Selector, view : UIViewController) -> UIBarButtonItem {
        let btn : UIBarButtonItem!
        if let img = image {
            btn = UIBarButtonItem(image: img, style: .done, target: view , action: selector)
        } else {
            btn = UIBarButtonItem(title: name! , style: .done, target: view , action: selector)
        }
        return btn
    }
}

extension UIView {
    static func view() -> UIView {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.shadowColor = UIColor.gray.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
}

extension UIView {
    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
