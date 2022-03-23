//
//  TabBar.swift
//  Travel Register
//
//  Created by sunder-con870 on 07/02/22.
//

import UIKit

class TRTabBar : UIViewController{
    
    ///Data's
    var home = TRHome()
    var travel = TRTravels()
    var friends = TRFriends()
    var activity = TRActivities()
    lazy var tabBar = tabBarControl()
    
    ///Functions
    private func tabBarControl() -> UITabBarController {
        let tc = UITabBarController()
        UIBlurEffect.addBlur(view: tc.tabBar)
        let v1 = attachNC(vc: home,title: "Home", tabBarImg: UIImage(systemName: "house")!)
        let v2 = attachNC(vc: travel,title: "Travel's", tabBarImg: UIImage(systemName: "globe.asia.australia")!)
        let v3 = attachNC(vc: friends,title: "Friends", tabBarImg: UIImage(systemName: "person.2")!)
        let v4 = attachNC(vc: activity,title: "Activities", tabBarImg: UIImage(systemName: "figure.walk")!)
        tc.setViewControllers([v1,v2,v3,v4], animated: true)
        tc.delegate = self
        tc.modalPresentationStyle = .fullScreen
        return tc
    }
    private func attachNC(vc : UIViewController, title : String,tabBarImg : UIImage) -> UINavigationController{
        let v = UINavigationController(rootViewController: vc)
        v.title = title
        v.tabBarItem.image = tabBarImg
        return v
    }
}

extension TRTabBar: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = tabBar.selectedViewController?.view, let toView = viewController.view else {
          return false
        }
        TRLoginVC.tabBarVCs.home.update()
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}
