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
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: string) else { return "" }
        dateFormatter.dateFormat = "dd MMM yyyy  HH:mm"

        return dateFormatter.string(from: date)
    }
    
    class func showReportActionSheet(vc: UIViewController,
                                     success: VoidCompletion?) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Пожаловаться на отчёт", style: .destructive) { action in
            success?()
        })
        
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil))
        
        DispatchQueue.main.async(execute: {
            vc.present(alert, animated: true)
        })
    }
    
}
