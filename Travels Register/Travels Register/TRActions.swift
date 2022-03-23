//
//  CommonCode.swift
//  Travel Register
//
//  Created by sunder-con870 on 17/02/22.
//

import UIKit


class TRActions {
//    private static var tempSB : UISearchController!
    private static var currentVC : UIViewController!
    private static var editButton : UIButton!
    static func addNew(newView : UIViewController, title : String, view : UIViewController, saveSelector : Selector, backSelector : Selector, presentView : UIViewController) {
        newView.title = title
        let navi = UINavigationController(rootViewController: newView)
        newView.navigationItem.leftBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.cancel.rawValue), selector: backSelector, view: view)
        newView.navigationItem.rightBarButtonItem = UIBarButtonItem.button(name: "Save", selector: saveSelector, view: view)
        newView.navigationItem.rightBarButtonItem?.isEnabled = false
        presentView.present(navi, animated: true)
    }
    static func delete(currentTripIndex : Int, selectedIndex : Int, yes : UIAlertAction,view : UIViewController) {
        let alert = UIAlertController(title: "Are You Sure!",
                                      message: "Do you want to Delete this Record? ",
                                      preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .cancel) { action in
        }
        alert.addAction(yes)
        alert.addAction(no)
        view.present(alert, animated: true, completion: nil)
    }
    static func enableEdit(view : UIViewController, saveSelector : Selector,cancelSelector : Selector, self : UIViewController) {
        UIView.animate(withDuration: 0.3, animations: {
            view.navigationItem.rightBarButtonItem = nil
            TRActions.editButton.alpha = 0
            view.navigationItem.rightBarButtonItem = UIBarButtonItem.button(name: "Save", selector: saveSelector, view: self)
            view.navigationItem.leftBarButtonItem = UIBarButtonItem.button(name: "Cancel", selector: cancelSelector, view: self)
        })
    }
    static func disableEdit(view : UIViewController, delectSelector : Selector, self : UIViewController) {
        UIView.animate(withDuration: 0.3, animations: {
            view.navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.trash.rawValue), selector: delectSelector, view: self)
            TRActions.editButton.alpha = 1
            view.navigationItem.leftBarButtonItem = nil
        })
    }
    static func asDisplayView(view : UIViewController, deleteSelector : Selector, editSelector : Selector, self : UIViewController) {
        TRActions.editButton = UIButton().bottomButton(type: "pencil")
        view.navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.trash.rawValue), selector: deleteSelector, view: view)
        TRActions.editButton.addTarget(view, action: editSelector, for: .touchUpInside)
        view.view.addSubview(TRActions.editButton)
        
        TRActions.editButton.bottomButtonConstraints(button: TRActions.editButton, view: view.view)
        self.navigationController?.pushViewController(view, animated: true)
    }
    static func configureVCHelper(selfVC : UIViewController, addSelector : Selector, view : UIView) {
        let tempSB = UISearchController()
        view.backgroundColor = .systemBackground
        selfVC.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.plus.rawValue), selector: addSelector, view: selfVC)
        selfVC.navigationItem.rightBarButtonItem = addButton
        selfVC.navigationItem.searchController = tempSB
        selfVC.navigationItem.searchController?.searchResultsUpdater = selfVC as? UISearchResultsUpdating
        selfVC.navigationItem.hidesSearchBarWhenScrolling = false
        TRActions.currentVC = selfVC
    }
    static func showToast(message: String, window : UIWindow) {
    
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 18)
        toastLbl.textColor = UIColor.systemBackground
        toastLbl.backgroundColor = UIColor.systemGray.withAlphaComponent(0.8)
        toastLbl.numberOfLines = 0
        
        
        let textSize = toastLbl.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        window.addSubview(toastLbl)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
        }
    }
}
