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

    let locationManager = CLLocationManager()
    var isLocation: Bool = true
   // var location = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        createTapGestureRecognizer()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        isLocation = true
        setHiddenBlackArrowButton()
    }

    private func configure() {
        dumpImageView.layer.cornerRadius = 10.0
        dumpImageView.layer.masksToBounds = true
        
        descriptionTextView.layer.cornerRadius = 10.0
        descriptionTextView.layer.masksToBounds = true
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = Design.lightGray.cgColor
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        

    }
    
    @IBAction func mapActionButton(_ sender: UIButton) {
        getLocation()
    }
    
    private func getLocation() {
        
        let showError = {
            let alert  = UIAlertController(title: "Warning",
                                           message: "",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        guard CLLocationManager.locationServicesEnabled() else {
            showError()
            return
        }

        switch CLLocationManager.authorizationStatus() {
        case .denied, .notDetermined, .restricted:
            showError()
        default:
            locationManager.startUpdatingLocation()
        }
    }


    
    private func createTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAlert))
        dumpImageView.isUserInteractionEnabled = true
        dumpImageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension CreateReportVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func showAlert() {
        
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
        dumpImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
}

// MARK: - CLLocationManagerDelegate

extension CreateReportVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        //Utill.printInTOConsole(">> locations- \(locations)")
        
        if isLocation {
            Utill.latitude = locations.first?.coordinate.latitude
            Utill.longitude = locations.first?.coordinate.longitude
            showGoogleMapsVC()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Transition

extension CreateReportVC {
    
    private func showGoogleMapsVC() {
        
        let loginVCStoryboard = UIStoryboard(name: "GoogleMapsVC", bundle: nil)
        guard let vc = loginVCStoryboard.instantiateViewController(withIdentifier: "GoogleMapsVC") as? GoogleMapsVC else {
            return
        }
        isLocation = false
        pushViewController(vc)
    }
    
}


//extension DetailsViewController: UITextViewDelegate {
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//
//
//    }
//
//}
