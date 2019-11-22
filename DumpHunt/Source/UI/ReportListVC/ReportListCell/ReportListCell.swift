//
//  ReportListCell.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

class ReportListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        configure()
        
    }


    private func configure() {
        

        selectionStyle = .none
    }
    
}
