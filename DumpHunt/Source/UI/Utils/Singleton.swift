//
//  Singleton.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import Foundation

final class Singleton {
    static let shared = Singleton()
    private init() { }
    
    var latitude = String()
    var longitude = String()
}
