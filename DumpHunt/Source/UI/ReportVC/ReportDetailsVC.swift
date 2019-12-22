//
//  ReportDetailsVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class ReportDetailsVC: BaseVC {

    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var fioLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var commentTextView: UITextView!

    var report: Report?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setReport()
    }
    
    func setReport() {
        
        if let dumpImage = report?.photo {
            dumpImageView.image = dumpImage
        }
        
        if let latitude = report?.latitude {
            latitudeLabel.text = String(latitude)
        }
        
        if let longitude = report?.longitude {
            longitudeLabel.text = String(longitude)
        }
        
        if let fio = report?.fio {
            fioLabel.text = fio
        }
        
        if let contact = report?.phone {
            contactLabel.text = contact
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
