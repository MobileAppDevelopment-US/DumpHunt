//
//  DesignModel.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

typealias Design = DesignModel

open class DesignModel {
    
     static let keyLatitude: String = "keyLatitude"
     static let keyLongitude: String = "keyLongitude"
    
    // Fonts Size
    
    static let small: CGFloat = 13.0
    static let medium: CGFloat = 16.0
    static let standart: CGFloat = 17.0
    static let big: CGFloat = 20.0

    // Fonts

    // Colors
    
    public static var black: UIColor { return .black }
    public static var white: UIColor { return .white }
    public static var lightGray: UIColor { return .lightGray }

    public static var blue: UIColor { return UIColor(red: 5.0/255.0,
                                                     green: 124.0/255.0,
                                                     blue: 255.0/255.0,
                                                     alpha: 1.0)
    }
    
    public static var green: UIColor { return UIColor(red: 44.0/255.0,
                                                      green: 181.0/255.0,
                                                      blue: 77.0/255.0,
                                                      alpha: 1.0)
    }
    
    public static var orange: UIColor { return UIColor(red: 240.0/255.0,
                                                       green: 118.0/255.0,
                                                       blue: 44.0/255.0,
                                                       alpha: 1.0)
    }
    
    public static var gray: UIColor { return UIColor(red: 237.0/255.0,
                                                         green: 237.0/255.0,
                                                         blue: 237.0/255.0,
                                                         alpha: 1.0)
    }
    
    public static var grayText: UIColor { return UIColor(red: 160.0/255.0,
                                                         green: 160.0/255.0,
                                                         blue: 160.0/255.0,
                                                         alpha: 1.0)
    }

}
