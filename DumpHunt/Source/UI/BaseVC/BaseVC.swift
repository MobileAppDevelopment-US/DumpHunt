//
//  BaseVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseVC: UIViewController {

    // MARK: - Properties

    private var hud: JGProgressHUD?
    let networkClient = NetworkClient()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackArrowButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Design.white]
    }
    
    // MARK: - BackArrowButton

    func setBackArrowButton() {
        self.navigationController?.navigationBar.barTintColor = Design.green
        self.navigationController?.navigationBar.tintColor = Design.white

        let buttonItem = UIBarButtonItem(image: UIImage.init(named: "BackArrow"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = buttonItem
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    @objc func leftButtonAction(_ button: UIBarButtonItem) {
        popViewController()
     }
    
    func setHiddenBlackArrowButton() {
        navigationController?.navigationBar.tintColor = .clear
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.hidesBackButton = true
    }

    // MARK: - NavigationBar

    func notSelectedPostReportButton(_ button: UIButton) {
         
         button.backgroundColor = Design.gray
         button.tintColor = Design.grayText
         button.isEnabled = false
     }
     
    func selectedPostReportButton(_ button: UIButton) {
         
         button.backgroundColor = Design.orange
         button.tintColor = Design.white
         button.isEnabled = true
     }
    
    func hideNavigationBar(_ isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
    
}

// MARK: - Spinner

extension BaseVC {
    
    func showSpinner() {
        hideSpinner()
        hud = JGProgressHUD(style: .dark)
        hud?.show(in: self.view)
    }
    
    func hideSpinner() {
        hud?.dismiss(afterDelay: 0.1)
        hud = nil
    }
    
}

// MARK: - CheckConnectedToInternet

extension BaseVC {
    
    func checkConnectedToInternet() {
        
        if networkClient.isConnectedToInternet == false {
            showConnectedToInternetAlert()
        }
    }
    
    func showConnectedToInternetAlert() {
        
        let controller = UIAlertController(title: Constants.noInternet,
                                           message: Constants.connectToInternet,
                                           preferredStyle: .alert)
        
        let ok = UIAlertAction(title: Constants.ok,
                               style: .default,
                               handler: nil)
        let cancel = UIAlertAction(title: Constants.cancel,
                                   style: .cancel,
                                   handler: nil)
        
        controller.addAction(ok)
        controller.addAction(cancel)
        
        present(controller, animated: true, completion: nil)
    }
   
}

// MARK: - ErrorAlert

extension BaseVC {
    
    func showErrorAlert(_ message: String?) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok,
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
}
