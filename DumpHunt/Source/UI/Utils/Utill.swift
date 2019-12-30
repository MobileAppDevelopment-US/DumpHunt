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
    
    class func getFormattedDate(string: String) -> String {
                
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // This formate is input formated .
        
        guard let date = dateFormatter.date(from: string) else { return "" }
        dateFormatter.dateFormat = "ddMMM yyyy  HH:mm" // Output Formated
        
        return dateFormatter.string(from: date)
    }
    
}
