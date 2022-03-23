//
//  Setting.swift
//  Travel Register
//
//  Created by sunder-con870 on 23/02/22.
//

import UIKit
import Network

class TRSetting : UIViewController {

    private let selectLabel = TRWidget.label(name: "Select a Currency Type:")
    private let currencyTextField = TRWidget.textField(placeHolder: "", tintColor: .clear)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    private func configureVC() {
        title = "Setting"
        view.addSubview(selectLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .done, target: self, action: #selector(restoreData))
        selectLabel.font = .systemFont(ofSize: 20, weight: .thin)
        TRWidget.positionMaker(view: selectLabel, width: view.frame.width - 20, height: 35, left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, leftCon: 10, topCon: 10)
        view.addSubview(currencyTextField)
        if let value = TRDataTool.userDefault.value(forKey: "currencyName") as? Int {
            currencyTextField.text = "\(TRCurrency.allCases[value])"
        }
        
        TRWidget.positionMaker(view: currencyTextField, width: view.frame.width - 20, height: 35, left: view.leftAnchor, top: selectLabel.bottomAnchor, leftCon: 10, topCon: 10)
        currencyTextField.backgroundColor = .systemGray6
        currencyTextField.addGestureRecognizer(TRWidget.tapGesture(view: self, selector: #selector(presentCurrencyVC), taps: 1))
    }
    @objc func restoreData() {
        RestoreData.deleteData()
        RestoreData.restoreData()
        TRLoginVC.loadDatas()
        TRLoginVC.tabBarVCs.travel.loadDatatoView()
        TRLoginVC.tabBarVCs.friends.loadDatatoView()
        TRLoginVC.tabBarVCs.activity.loadDatatoView()
        TRLoginVC.tabBarVCs.home.update()
    }
    @objc func presentCurrencyVC() {
        
        let path = NWPathMonitor()
        path.start(queue: DispatchQueue.global(qos: .default))
        path.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    let vc = TRCurrencyTableVC()
                    vc.view.backgroundColor = .systemBackground
                    let navi = UINavigationController(rootViewController: vc)
                    if let presentationController = navi.presentationController as? UISheetPresentationController {
                        presentationController.detents = [.medium()]
                    }
                    vc.selectionDelegate = self
                    self.present(navi, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Retry!", message: "No Network Conncetion..!", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel) {_ in
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension TRSetting : CurrencySelectionDelegate {
    func didTapCurrency(name: String) {
        currencyTextField.text = name
    }
}
