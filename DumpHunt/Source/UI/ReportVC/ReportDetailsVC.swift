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
        
        if let dumpImage = report?.photo {
            dumpImageView.image = dumpImage
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

//extension ReportDetailsVC {
//    
//    struct ViewModel {
//        var dumpImage: UIImage?
//        let latitude: String?
//        var longitude: String?
//        let fio: String?
//        let contact: String?
//        var comment: String?
//        
//        init(dumpImage: UIImage?,
//             latitude: String?,
//             longitude: String?,
//             fio: String?,
//             contact: String?,
//             comment: String?)
//        {
//            self.dumpImage = dumpImage
//            self.latitude = latitude
//            self.longitude = longitude
//            self.fio = fio
//            self.contact = contact
//            self.comment = comment
//        }
//    }
//}
