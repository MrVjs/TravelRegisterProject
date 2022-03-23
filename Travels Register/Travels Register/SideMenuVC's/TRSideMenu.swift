//
//  SideMenus.swift
//  Travel Register
//
//  Created by sunder-con870 on 31/01/22.
//

import UIKit


class TRSideMenu : UITableView, UITableViewDelegate, UITableViewDataSource {
    var currentVC : UIViewController!
    private var vc : UIViewController!
    lazy var menuVCs = [TRProfile.self,TRNotification.self,TRSetting.self,TRAbout.self]
    private var names = ["Profile","Notification","Settings","About"]
    private var imgs = ["person.crop.circle","bell.fill","gear","info.circle"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuVCs.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vc = menuVCs[indexPath.row].init()
        vc.view.backgroundColor = .systemBackground
        let navi = UINavigationController(rootViewController: vc)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem.button(image: UIImage(systemName: TRIcon.cancel.rawValue), selector: #selector(TRHome().backTapped), view: currentVC.self)
        navi.modalTransitionStyle = .coverVertical
        navi.navigationBar.prefersLargeTitles = true
        currentVC.present(navi, animated: true, completion: nil)
        TRLoginVC.tabBarVCs.home.update()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(systemName: imgs[indexPath.row])
        cell.backgroundColor = .systemBackground
        return cell
    }
    @objc func backTapped() {
        currentVC.dismiss(animated: true, completion: nil)
        vc = nil
    }
}
