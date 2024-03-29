//
//  TabBarVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // Mark: Methods
    
    private func configure() {
                
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        tabBar.items?[0].title = Constants.createReport
        tabBar.items?[1].title = Constants.list
        tabBar.items?[2].title = Constants.aboutProject

        tabBar.tintColor = Design.green
        tabBar.isTranslucent = false
    }

}
