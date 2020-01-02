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
    
    // API

    static let ApiUrlPath = "http://teachyourself.pythonanywhere.com/api/v1"
    
    // Key

    static let keyLatitude: String = "keyLatitude"
    static let keyLongitude: String = "keyLongitude"
    static let keyShowRequestLocation: String = "keyShowRequestLocation"
    static let keyProvideAPI: String = "AIzaSyCZeTgAhBUfnrL63b4KY2BSz1TLoZanlnU"
    
    // Fonts
    
    static let sourceSansProRegular: String = "SourceSansPro-Regular"
    
    // Fonts Size

    static let medium: CGFloat = 14.0
    
    // Colors
    
    public static var white: UIColor { return .white }
    public static var lightGray: UIColor { return .lightGray }
    
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
