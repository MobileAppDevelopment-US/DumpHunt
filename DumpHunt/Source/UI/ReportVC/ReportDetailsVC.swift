//
//  ReportDetailsVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

protocol ReportListVCDelegate: class {
    func setIsGetReports(_ isGetReports: Bool)
}

final class ReportDetailsVC: BaseVC {

    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var commentTextView: UITextView!

    var report: Report?
    weak var delegate: ReportListVCDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setReport()
    }
    
    // Mark: Action
    
    override func leftButtonAction(_ button: UIBarButtonItem) {
        super.leftButtonAction(button)
        
        delegate?.setIsGetReports(false)
    }
    
    // Mark: Methods

    private func setReport() {
        
        if let textUrl = report?.photoURL, let url = URL(string: textUrl) {
            dumpImageView.kf.setImage(with: url,
                                        placeholder: Utill.getPlaceholder(),
                                        options: [.transition(.fade(1)),
                                                  .cacheOriginalImage])
        } else {
            dumpImageView.image = Utill.getPlaceholder()
        }
        
        
        if let latitude = report?.latitude {
            latitudeLabel.text = String(latitude)
        }
        
        if let longitude = report?.longitude {
            longitudeLabel.text = String(longitude)
        }

        if let comment = report?.comment {
            commentTextView.text = comment
        }
    }

}

