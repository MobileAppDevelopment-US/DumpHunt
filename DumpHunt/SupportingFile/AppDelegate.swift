//
//  AppDelegate.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UILabel.appearance().font = UIFont(name: Design.sourceSansProRegular, size: Design.medium)
        GMSServices.provideAPIKey(Design.keyProvideAPI)
        IQKeyboardManager.shared.enable = true
        openFirstScreen()
        
        return true
    }

    private func openFirstScreen() {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let notFirstEnter = UserDefaults.standard.bool(forKey: Design.notFirstEnter)

        if notFirstEnter {
            
         let storyboard = UIStoryboard(name: "TabBarVC", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
            window?.rootViewController = tabBarVC
            window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "ConfirmationVC", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "ConfirmationVC") as! ConfirmationVC
            let nc = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = nc
        }
        window?.makeKeyAndVisible()
    }
    
}

