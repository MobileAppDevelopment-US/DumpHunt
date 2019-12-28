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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey("AIzaSyCZeTgAhBUfnrL63b4KY2BSz1TLoZanlnU")
        IQKeyboardManager.shared.enable = true
        openFirstScreen()
        return true
    }

    private func openFirstScreen()
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "TabBarVC", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
}

