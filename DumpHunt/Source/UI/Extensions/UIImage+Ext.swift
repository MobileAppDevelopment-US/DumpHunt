//
//  Extensions+UIImage.swift
//  DumpHunt
//
//  Created by Serik on 08.12.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit

extension UIImage {
    
    func fixOrientation() -> UIImage? {
        
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
