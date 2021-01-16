//
//  UIStoryboard+Ext.swift
//  DumpHunt
//
//  Created by Serik on 16.01.2021.
//  Copyright © 2021 Serik_Klement. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var googleMapsVC: UIStoryboard {
        return UIStoryboard(name: "GoogleMapsVC", bundle: nil)
    }
    
    static var reportDetailsVC: UIStoryboard {
        return UIStoryboard(name: "ReportDetailsVC", bundle: nil)
    }
    
    static var tabBarVC: UIStoryboard {
        return UIStoryboard(name: "TabBarVC", bundle: nil)
    }
    
    static var confirmationVC: UIStoryboard {
        return UIStoryboard(name: "ConfirmationVC", bundle: nil)
    }

}
