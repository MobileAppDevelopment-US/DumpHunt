//
//  Utill.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

final class Utill: NSObject {
    
    class func printInTOConsole(_ printData : Any) {
        #if DEBUG
        print("\(printData)")
        #endif
    }

    class func getPlaceholder() -> UIImage {
        return UIImage(named: "placeholder")!
    }
    
}
