//
//  Report.swift
//  DumpHunt
//
//  Created by Serik on 08.12.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

//MARK: - Report

struct Report
{
    var image: UIImage?
    var fio: String?
    var phone: String?
    var comment: String?
    var latitude: Double?
    var longitude: Double?

    init(image: UIImage? = nil,
         fio: String? = nil,
         phone: String? = nil,
         comment: String? = nil,
         latitude: Double? = nil,
         longitude: Double? = nil)
    {
        self.image = image
        self.fio = fio
        self.phone = phone
        self.comment = comment
        self.latitude = latitude
        self.longitude = longitude
    }
}

