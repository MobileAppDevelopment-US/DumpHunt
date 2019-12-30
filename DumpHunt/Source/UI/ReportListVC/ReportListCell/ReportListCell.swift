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

    @IBOutlet var gpsLabel: UILabel!
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
        
        dateLabel.text = Utill.getFormattedDate(string: report?.date)
//        if let latitude = report?.latitude, let longitude = report?.longitude{
//            gpsLabel.text = latitude + longitude
//        }
//        
//        if let comment = report?.comment {
//            commentLabel.text = comment
//        }
        
        selectionStyle = .none
        bottomView.backgroundColor = Design.lightGray
    }
    
}
