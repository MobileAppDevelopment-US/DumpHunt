//
//  CreateReportVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import CoreLocation

class CreateReportVC: BaseVC {
    
    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var fioTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var postReportButton: UIButton!
    
    var report = Report() {
        didSet {
            if report.image != nil && report.latitude != nil && report.longitude != nil {
                selectedNextButton()
            } else {
                notSelectedtButton()
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        createTapGestureRecognizer()
        notSelectedtButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
    }
    
    // Mark: Action
    
    @IBAction func mapActionButton(_ sender: UIButton) {
        showGoogleMapsVC()
    }
    
    @IBAction func postReportActionButton(_ sender: UIButton) {
        Utill.printInTOConsole(">>> Report - \(report)")
    }
    
    // Mark: Mehods
    
    private func configure() {
        dumpImageView.layer.cornerRadius = 10.0
        dumpImageView.layer.masksToBounds = true
        
        descriptionTextView.layer.cornerRadius = 10.0
        descriptionTextView.layer.masksToBounds = true
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = Design.lightGray.cgColor
        
        postReportButton.layer.cornerRadius = postReportButton.frame.size.height / 2
        postReportButton.layer.masksToBounds = true
        
        descriptionTextView.delegate = self
        fioTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    func notSelectedtButton() {
        
        postReportButton.backgroundColor = Design.gray
        postReportButton.tintColor = Design.grayText
        //nextButton.titleLabel?.font = UIFont(name: Design.avenirBold, size: Design.medium)
        postReportButton.isEnabled = false
    }
    
    private func createTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showSelectPhotoAlert))
        dumpImageView.isUserInteractionEnabled = true
        dumpImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func selectedNextButton() {
        
        postReportButton.backgroundColor = Design.blue
        postReportButton.tintColor = Design.white
        postReportButton.isEnabled = true
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension CreateReportVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func showSelectPhotoAlert() {
        
        let alert = UIAlertController(title: "Выберите источник фото",
                                      message: "",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Камера",
                                      style: .default,
                                      handler: {(action: UIAlertAction) in
                                        self.getImage(fromSourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Альбом",
                                      style: .default,
                                      handler: {(action: UIAlertAction) in
                                        self.getImage(fromSourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Отменить",
                                      style: .cancel,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func getImage(fromSourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(fromSourceType) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = fromSourceType
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let orientationFixedImage = chosenImage.fixOrientation()
        report.image = orientationFixedImage
        dumpImageView.image = orientationFixedImage
        dismiss(animated:true, completion: nil)
    }
    
}

// MARK: - Transition

extension CreateReportVC {
    
    private func showGoogleMapsVC() {
        
        let storyboard = UIStoryboard(name: "GoogleMapsVC", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "GoogleMapsVC") as? GoogleMapsVC else {
            return
        }
        vc.delegate = self
        pushViewController(vc)
    }
    
}

// MARK: - CreateReportVCDelegate

extension CreateReportVC: CreateReportVCDelegate {
    
    func setCurrentCoordinate(latitude: Double?, longitude: Double?) {
        report.latitude = latitude
        report.longitude = longitude
    }
    
}


// MARK: - UITextViewDelegate

extension CreateReportVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        report.comment = textView.text
    }
    
}

// MARK: - UITextFieldDelegate

extension CreateReportVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let textFieldText = textField.text,
            let textRange = Range(range, in: textFieldText) else {
                return false
        }
        let text = textFieldText.replacingCharacters(in: textRange, with: string)
        
        if textField == fioTextField {
            report.fio = text
        }
        
        if textField == phoneTextField {
            report.phone = text
        }
        
        return true
    }
    
}


