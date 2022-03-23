//
//  CommonCode.swift
//  Travel Register
//
//  Created by sunder-con870 on 17/02/22.
//

import UIKit


class TRActions {
    private static var currentVC : UIViewController!
    private static var editButton : UIButton!
    static func addNew(newView : UIViewController, title : String, view : UIViewController, saveSelector : Selector, backSelector : Selector, presentView : UIViewController) {
        newView.title = title
        let navi = UINavigationController(rootViewController: newView)
        newView.navigationItem.leftBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: IconNames.backArrow.rawValue), selector: backSelector, view: view)
        newView.navigationItem.rightBarButtonItem = UIBarButtonItem.button(name: "Save", selector: saveSelector, view: view)
        newView.navigationItem.rightBarButtonItem?.isEnabled = false
        navi.modalPresentationStyle = .fullScreen
        presentView.present(navi, animated: true, completion: nil)
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
            view.navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: IconNames.trash.rawValue), selector: delectSelector, view: self)
            TRActions.editButton.alpha = 1
            view.navigationItem.leftBarButtonItem = nil
        })
    }
    static func asDisplayView(view : UIViewController, deleteSelector : Selector, editSelector : Selector, self : UIViewController) {
        TRActions.editButton = UIButton().bottomButton(type: "pencil")
        view.navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: IconNames.trash.rawValue), selector: deleteSelector, view: view)
        TRActions.editButton.addTarget(view, action: editSelector, for: .touchUpInside)
        view.view.addSubview(TRActions.editButton)
        TRActions.editButton.bottomButtonConstraints(button: TRActions.editButton, view: view.view)
        self.navigationController?.pushViewController(view, animated: true)
    }
    static func configureVCHelper(self : UIViewController, addSelector : Selector, view : UIView) {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: IconNames.plus.rawValue), selector: addSelector, view: self)
        TRActions.currentVC = self
    }
    
}
