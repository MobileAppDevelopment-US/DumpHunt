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

    private var hud: JGProgressHUD?
    let networkClient = NetworkClient()

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
         self.navigationController?.popViewController(animated: true)
     }
    
    func setHiddenBlackArrowButton() {
        navigationController?.navigationBar.tintColor = .clear
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.hidesBackButton = true
    }

    // MARK: - NavigationBar

    func setNavigationBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Transition VC

    func pushViewController(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        let controller = UIAlertController(title: "Отсутсвует интернет",
                                           message: "Для получения или отправки данных подключитесь к Интернету",
                                           preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil)
        let cancel = UIAlertAction(title: "Отменить",
                                   style: .cancel,
                                   handler: nil)
        
        controller.addAction(ok)
        controller.addAction(cancel)
        
        present(controller, animated: true, completion: nil)
    }
    
}
