//
//  Report.swift
//  DumpHunt
//
//  Created by Serik on 08.12.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

//MARK: - Report

class Report: Codable
{
    var photo: UIImage?
    var photoURL: String?
    var fio: String?
    var phone: String?
    var comment: String?
    var latitude: String?
    var longitude: String?

    enum CodingKeys: String, CodingKey {
        case comment
        case photoURL = "photo"
        case latitude = "lat"
        case longitude = "long"
        case fio = "feedback_info"
    }
    
    init(photo: UIImage? = nil,
         photoURL: String? = nil,
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.photoURL = try? values.decode(String.self, forKey: .photoURL)
        self.comment = try? values.decode(String.self, forKey: .comment)
        self.latitude = try? values.decode(String.self, forKey: .latitude)
        self.longitude = try? values.decode(String.self, forKey: .longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container .encode(photoURL, forKey: .photoURL)
        try container .encode(comment, forKey: .comment)
        try container .encode(latitude, forKey: .latitude)
        try container .encode(longitude, forKey: .longitude)
    }
}

