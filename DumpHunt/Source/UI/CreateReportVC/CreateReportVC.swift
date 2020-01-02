//
//  CreateReportVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import CoreLocation

final class CreateReportVC: BaseVC {
    
    // MARK: - Outlets

    @IBOutlet var dumpImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var fioTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var gpsLabel: UILabel!
    @IBOutlet var postReportButton: UIButton!
    @IBOutlet var openMapButton: UIButton!

    var reportVM = ReportVM()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        createTapGestureRecognizer()
        notSelectedPostReportButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setHiddenBlackArrowButton()
        checkConnectedToInternet()
    }
    
    // Mark: Actions
    
    @IBAction func mapActionButton(_ sender: UIButton) {
        reportVM.latitude = nil
        reportVM.longitude = nil
        gpsLabel.text = ""
        gpsLabel.isHidden = true
        showGoogleMapsVC()
    }
    
    @IBAction func postReportActionButton(_ sender: UIButton) {
        
        if networkClient.isConnectedToInternet == true {
            postSaveReport()
        } else {
            showConnectedToInternetAlert()
        }
    }
    
    // Mark: Methods
    
    private func configure() {
        
        dumpImageView.layer.cornerRadius = 10.0
        dumpImageView.layer.masksToBounds = true
        
        configureView(gpsLabel)
        gpsLabel.isHidden = true
        
        configureView(descriptionTextView)
        configureView(fioTextField)
        configureView(phoneTextField)
        
        postReportButton.layer.cornerRadius = postReportButton.frame.size.height / 2
        postReportButton.layer.masksToBounds = true
        
        descriptionTextView.delegate = self
        fioTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    private func configureView(_ view: UIView) {
        
        view.layer.cornerRadius = 4.0
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = Design.lightGray.cgColor
    }
    
    private func notSelectedPostReportButton() {
        
        postReportButton.backgroundColor = Design.gray
        postReportButton.tintColor = Design.grayText
        postReportButton.isEnabled = false
    }
    
    private func createTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showSelectPhotoAlert))
        dumpImageView.isUserInteractionEnabled = true
        dumpImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func selectedPostReportButton() {
        
        postReportButton.backgroundColor = Design.orange
        postReportButton.tintColor = Design.white
        postReportButton.isEnabled = true
    }
    
    private func isEnabledPostReportButton() {
        if reportVM.photo != nil && reportVM.latitude != nil && reportVM.longitude != nil {
            selectedPostReportButton()
        } else {
            notSelectedPostReportButton()
        }
    }

}

// MARK: - NetworkClient

extension CreateReportVC {
    
    private func postSaveReport() {
        
        postReportButton.isUserInteractionEnabled = false
        showSpinner()
        
        networkClient.postSaveReport(reportVM: reportVM,
                                     success: { [weak self] () in
                                        guard let self = self else { return }
                                        self.postReportButton.isUserInteractionEnabled = true
                                        
                                        DispatchQueue.main.async {
                                            self.hideSpinner()
                                            self.showSuccessAlert("Данные отправлены")
                                        }
            },
                                     failure:
            { [weak self] (message) in
                guard let self = self else { return }
                self.hideSpinner()
                self.showErrorAlert(message)
                self.postReportButton.isUserInteractionEnabled = true
        })
    }
    
    private func dataCleaning() {
        reportVM = ReportVM()
        dumpImageView.image = UIImage(named: "addPhotoPlaceholder.jpg")
        gpsLabel.text = ""
        gpsLabel.isHidden = true
        fioTextField.text = ""
        descriptionTextView.text = ""
        phoneTextField.text = ""
    }
    
    private func showSuccessAlert(_ message: String?) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { _ in
                                        self.dataCleaning()
                                        self.notSelectedPostReportButton()
        }))
        self.present(alert, animated: true)
    }
    
    private func showErrorAlert(_ message: String?) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
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
        reportVM.photo = orientationFixedImage
        dumpImageView.image = orientationFixedImage
        isEnabledPostReportButton()
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
        vc.typeVC = .show
        pushViewController(vc)
    }
    
}

// MARK: - CreateReportVCDelegate

extension CreateReportVC: CreateReportVCDelegate {
    
    func setCurrentCoordinate(latitude: Double?, longitude: Double?) {
        
        if let latitude = latitude, let longitude = longitude {
            reportVM.latitude = String(latitude)
            reportVM.longitude = String(longitude)
            gpsLabel.text = "  GPS: \(latitude)  \(longitude)"
            gpsLabel.isHidden = false
            isEnabledPostReportButton()
        } else {
            gpsLabel.isHidden = true
        }
    }
    
}

// MARK: - UITextViewDelegate

extension CreateReportVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        reportVM.comment = textView.text
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
            reportVM.fio = text
        }
        
        if textField == phoneTextField {
            reportVM.phone = text
        }
        
        return true
    }
    
}


