//
//  BaseVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackArrowButton()
        //view.backgroundColor = Design.orange
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
    
    
    func showErrorAlert(_ message: String?) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
}
