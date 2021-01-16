//
//  UIViewController+Ext.swift
//  DumpHunt
//
//  Created by Serik on 16.01.2021.
//  Copyright © 2021 Serik_Klement. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Transition VC

    static func instanceFromStoryboard(_ storyboard: UIStoryboard) -> UIViewController {
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    func pushViewController(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentViewController(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func hideNavigationBar(isHidden: Bool) {
        self.navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
    
    func showAlert(_ text: String, _ onClose:@escaping() -> Void = {}) {
        let alert = UIAlertController(title: nil,
                                      message:text,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.ok,
            style: .default,
            handler: {
                action in
                onClose()
        }))
        self.present(alert, animated: true)
    }
    
}
