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
    
    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!

    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setReport(_ report: Report?) {

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
            latitudeLabel.text = "Долгота: \(latitude)"
        }
        
        if let longitude = report?.longitude{
            longitudeLabel.text = "Широта: \(longitude)"
        }
        
        if let comment = report?.comment {
            commentLabel.text = comment
        }
        
        selectionStyle = .none
        bottomView.backgroundColor = Design.lightGray
    }
    
}
