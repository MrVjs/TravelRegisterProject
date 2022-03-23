//
//  Creator.swift
//  Travel Register
//
//  Created by sunder-con870 on 10/02/22.
//

import UIKit

struct TRWidget {
    
    static func positionMaker(view : UIView, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, right : NSLayoutAnchor<NSLayoutXAxisAnchor>, top : NSLayoutAnchor<NSLayoutYAxisAnchor>, bottom : NSLayoutAnchor<NSLayoutYAxisAnchor>, leftCon : CGFloat, rightCon : CGFloat, topCon : CGFloat, bottomCon : CGFloat) {
        positionMaker(view: view, left: left, leftCon: leftCon)
        positionMaker(view: view, right: right, rightCon: rightCon)
        positionMaker(view: view, top: top, topCon: topCon)
        positionMaker(view: view, bottom: bottom, bottomCon: bottomCon)
    }
    static func positionMaker(view : UIView, right : NSLayoutAnchor<NSLayoutXAxisAnchor>, bottom : NSLayoutAnchor<NSLayoutYAxisAnchor>, width : CGFloat,height : CGFloat, rightCon : CGFloat, bottomCon : CGFloat) {
        positionMaker(view: view, bottom: bottom, bottomCon: bottomCon)
        positionMaker(view: view, right: right, rightCon: rightCon)
        positionMaker(view: view, height: height)
        positionMaker(view: view, width: width)
    }
    
    static func positionMaker(view : UIView, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, right : NSLayoutAnchor<NSLayoutXAxisAnchor>, top : NSLayoutAnchor<NSLayoutYAxisAnchor>, bottom : NSLayoutAnchor<NSLayoutYAxisAnchor>, leftCon : CGFloat, righCon : CGFloat, topCon : CGFloat, bottomCon : CGFloat) {
        positionMaker(view: view, left: left, top: top, leftCon: leftCon, topCon: topCon)
        positionMaker(view: view, right: right, rightCon: righCon)
        positionMaker(view: view, bottom: bottom, bottomCon: bottomCon)
    }
    
    static func positionMaker(view : UIView, right : NSLayoutAnchor<NSLayoutXAxisAnchor>, rightCon : CGFloat) {
        view.rightAnchor.constraint(equalTo: right, constant: rightCon).isActive = true
    }
    static func positionMaker(view : UIView, bottom : NSLayoutAnchor<NSLayoutYAxisAnchor>, bottomCon : CGFloat) {
        view.bottomAnchor.constraint(equalTo: bottom, constant: bottomCon).isActive = true
    }
    static func positionMaker(view : UIView, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, leftCon : CGFloat) {
        view.leftAnchor.constraint(equalTo: left, constant: leftCon).isActive = true
    }
    static func positionMaker(view : UIView, top : NSLayoutAnchor<NSLayoutYAxisAnchor>, topCon : CGFloat) {
        view.topAnchor.constraint(equalTo: top, constant: topCon).isActive = true
    }
    static func positionMaker(view : UIView, width : CGFloat) {
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    static func positionMaker(view : UIView, height : CGFloat) {
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    static func positionMaker(view : UIView, height : CGFloat, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, top : NSLayoutAnchor<NSLayoutYAxisAnchor>,right : NSLayoutAnchor<NSLayoutXAxisAnchor>, leftCon : CGFloat, topCon : CGFloat, rightCon : CGFloat) {
        positionMaker(view: view, right: right, rightCon: rightCon)
        positionMaker(view: view, height: height)
        positionMaker(view: view, left: left, top: top, leftCon: leftCon, topCon: topCon)
    }
    
    static func positionMaker(view : UIView, width : CGFloat, height : CGFloat, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, top : NSLayoutAnchor<NSLayoutYAxisAnchor>, leftCon : CGFloat, topCon : CGFloat) {
        positionMaker(view: view, height: height)
        positionMaker(view: view, width: width)
        positionMaker(view: view, left: left, top: top, leftCon: leftCon, topCon: topCon)
    }
    static func positionMaker(view : UIView, left : NSLayoutAnchor<NSLayoutXAxisAnchor>, top : NSLayoutAnchor<NSLayoutYAxisAnchor>, leftCon : CGFloat, topCon : CGFloat) {
        positionMaker(view: view, left: left, leftCon: leftCon)
        positionMaker(view: view, top: top, topCon: topCon)
    }
    static func label(name : String) -> UILabel{
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }
    static func textField(placeHolder : String, tintColor : UIColor) -> UITextField {
        let tf = UITextField()
        tf.tintColor = tintColor
        tf.placeholder = placeHolder
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.layer.cornerRadius = 5
        tf.isUserInteractionEnabled = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }
    static func tapGesture(view : UIViewController, selector : Selector,taps : Int) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: view, action: selector)
        tap.numberOfTapsRequired = taps
        tap.numberOfTouchesRequired = 1
        return tap
    }
    static func swipeUp(view : UIViewController, selector : Selector) -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: view, action: selector)
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .up
        return swipe
    }
}
