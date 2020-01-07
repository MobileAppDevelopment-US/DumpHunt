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

    // MARK: - Outlets

    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    // MARK: - Properties

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
        
    @IBAction func mapActionButton(_ sender: UIButton) {
        showGoogleMapsVC()
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        
        Utill.showReportActionSheet(vc: self, success: {
            Utill.printInTOConsole(">>>showReportActionSheet")
        })
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

        if let date = report?.date {
            dateLabel.text = Utill.getFormattedDate(string: date)
        }

    }

}

// MARK: - Transition

extension ReportDetailsVC {
    
    private func showGoogleMapsVC() {
        
        let storyboard = UIStoryboard(name: "GoogleMapsVC", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "GoogleMapsVC") as? GoogleMapsVC else {
            return
        }
        vc.typeVC = .open
        vc.latitude = report?.latitude
        vc.longitude = report?.longitude
        pushViewController(vc)
    }
    
}
