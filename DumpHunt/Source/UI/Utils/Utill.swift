//
//  Utill.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class Utill: NSObject {
    
//    private static let userDefaults = UserDefaults.standard
//    
//    public static var longitude : Double? {
//        get { return userDefaults.double(forKey: Design.keyLongitude) }
//        set { userDefaults.setValue(newValue, forKey: Design.keyLongitude) }
//    }
//    
//    public static var latitude : Double? {
//        get { return userDefaults.double(forKey: Design.keyLatitude) }
//        set { userDefaults.setValue(newValue, forKey: Design.keyLatitude) }
//    }
    
    class func printInTOConsole(_ printData : Any) {
        #if DEBUG
        print("\(printData)")
        #endif
    }

    
}
