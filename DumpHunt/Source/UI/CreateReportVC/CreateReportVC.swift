//
//  CreateReportVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class CreateReportVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
    }

    private func configure() {

    }

}
