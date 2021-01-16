//
//  AboutProjectVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

final class AboutProjectVC: BaseVC {
    
    @IBOutlet var iconView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        createTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
    }
    
    // MARK: - Methods

    private func configure() {
        iconView.layer.borderWidth = 2
        iconView.layer.borderColor = Design.orange.cgColor
        iconView.layer.cornerRadius = iconView.frame.size.height / 2
        iconView.layer.masksToBounds = true
    }
    
    private func createTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showSite))
        iconView.isUserInteractionEnabled = true
        iconView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func showSite() {
        
        if let url = URL(string: Constants.SitePath), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
