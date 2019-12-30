//
//  Report.swift
//  DumpHunt
//
//  Created by Serik on 08.12.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import Foundation

//MARK: - Report

class ReportsData: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    let results: [Report]
}

class Report: Codable
{
    var comment: String?
    var photoURL: String?
    var latitude: Double?
    var longitude: Double?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case comment
        case photoURL = "photo"
        case latitude = "lat"
        case longitude = "long"
        case date = "datetime_received"
    }
    
    init(comment: String? = nil,
         photoURL: String? = nil,
         phone: String? = nil,
         latitude: Double? = nil,
         longitude: Double? = nil,
         date: String? = nil)
    {
        self.photoURL = photoURL
        self.comment = comment
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.photoURL = try? values.decode(String.self, forKey: .photoURL)
        self.comment = try? values.decode(String.self, forKey: .comment)
        self.latitude = try? values.decode(Double.self, forKey: .latitude)
        self.longitude = try? values.decode(Double.self, forKey: .longitude)
        self.date = try? values.decode(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container .encode(photoURL, forKey: .photoURL)
        try container .encode(comment, forKey: .comment)
        try container .encode(latitude, forKey: .latitude)
        try container .encode(longitude, forKey: .longitude)
        try container .encode(date, forKey: .date)
    }
}

