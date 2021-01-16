//
//  ReportListCell.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import Kingfisher

final class ReportListCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    
    static let identifier = "ReportListCell"
    
    // MARK: - Methods
    
    func setReport(_ report: Report?) {
        
        dumpImageView.layer.cornerRadius = 10.0
        dumpImageView.layer.masksToBounds = true
        
        if let textUrl = report?.photoURL, let url = URL(string: textUrl) {
            dumpImageView.kf.setImage(with: url,
                                      placeholder: Utill.getPlaceholder(),
                                      options: [.transition(.fade(1)),
                                                .cacheOriginalImage])
        } else {
            dumpImageView.image = Utill.getPlaceholder()
        }
        
        if let date = report?.date {
            dateLabel.text = Utill.getFormattedDate(string: date)
        }
        
        if let latitude = report?.latitude {
            latitudeLabel.text = "\(Constants.latitude)\(latitude)"
        }
        
        if let longitude = report?.longitude{
            longitudeLabel.text = "\(Constants.longitude)\(longitude)"
        }
        
        selectionStyle = .none
        bottomView.backgroundColor = Design.lightGray
    }
    
}
