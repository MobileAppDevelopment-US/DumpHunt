//
//  ReportVM.swift
//  DumpHunt
//
//  Created by Serik on 30.12.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

//MARK: - ViewModel

class ReportVM {
    
    var photo: UIImage?
    var fio: String?
    var phone: String?
    var comment: String?
    var latitude: String?
    var longitude: String?

    init(photo: UIImage? = nil,
         fio: String? = nil,
         phone: String? = nil,
         comment: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil)
    {
        self.photo = photo
        self.fio = fio
        self.phone = phone
        self.comment = comment
        self.latitude = latitude
        self.longitude = longitude
    }

}

