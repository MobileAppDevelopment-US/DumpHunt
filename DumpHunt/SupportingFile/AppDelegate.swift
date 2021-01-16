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
import AppsFlyerLib

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UILabel.appearance().font = UIFont(name: Design.sourceSansProRegular, size: Design.medium)
        GMSServices.provideAPIKey(Constants.keyProvideAPI)
        IQKeyboardManager.shared.enable = true
        setAppsFlyerLib()
        openFirstScreen()
        
        return true
    }

    private func openFirstScreen() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let notFirstEnter = UserDefaults.standard.bool(forKey: Constants.notFirstEnter)
        
        if notFirstEnter {
            guard let vc = TabBarVC.instanceFromStoryboard(.tabBarVC) as? TabBarVC else { return }
            window?.rootViewController = vc
        } else {
            guard let vc = ConfirmationVC.instanceFromStoryboard(.confirmationVC) as? ConfirmationVC else { return }
            let nc = UINavigationController(rootViewController: vc)
            window?.rootViewController = nc
        }
        window?.makeKeyAndVisible()
    }
    
    private func setAppsFlyerLib() {
        AppsFlyerLib.shared().appsFlyerDevKey = Constants.appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = Constants.appleAppID
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true
    }
    
}


// MARK: AppsFlyerTrackerDelegate

extension AppDelegate: AppsFlyerLibDelegate {
    
    // Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        print("onConversionDataSuccess data:")
        for (key, value) in installData {
            print(key, ":", value)
        }
        if let status = installData["af_status"] as? String {
            if (status == "Non-organic") {
                if let sourceID = installData["media_source"],
                   let campaign = installData["campaign"] {
                    print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
            if let is_first_launch = installData["is_first_launch"] as? Bool,
               is_first_launch {
                print("First Launch")
            } else {
                print("Not First Launch")
            }
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    
    //Handle Deep Link
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print("onAppOpenAttribution data:")
        for (key, value) in attributionData {
            print(key, ":",value)
        }
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
    
}
