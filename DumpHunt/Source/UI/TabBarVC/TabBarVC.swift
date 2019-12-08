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
    
    // Mark: Mehods

    private func configure() {
        
        //UITabBar.appearance().barTintColor = Design.white
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        tabBar.items?[0].title = "Создать"
        tabBar.items?[1].title = "Список"
        tabBar.items?[2].title = "О проекте"

        tabBar.tintColor = Design.green
        //tabBar.unselectedItemTintColor = Design.white

        tabBar.isTranslucent = false
    }

}
