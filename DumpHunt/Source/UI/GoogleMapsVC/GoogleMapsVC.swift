//
//  GoogleMapsVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import GoogleMaps

protocol CreateReportVCDelegate: class {
    func setCurrentCoordinate(latitude: Double?, longitude: Double?)
}

final class GoogleMapsVC: BaseVC {
    
    var mapView = GMSMapView()
    var currentMarker = GMSMarker()
    weak var delegate: CreateReportVCDelegate?
    let locationManager = CLLocationManager()
    var isLocation: Bool = true
    var latitude: Double?
    var longitude: Double?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocation()
    }
    
    // Mark: Actions
    
    override func leftButtonAction(_ button: UIBarButtonItem) {
        super.leftButtonAction(button)
        
        delegate?.setCurrentCoordinate(latitude: latitude, longitude: longitude)
    }
    
    // Mark: Methods
    
    private func getLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            switch CLLocationManager.authorizationStatus() {
                
            case .notDetermined:
                locationManager.startUpdatingLocation()
                locationManager.requestAlwaysAuthorization()
                break
                
            case .denied, .restricted:
                showDisabledLocationAlert()
                break
                
            case .authorizedAlways, .authorizedWhenInUse :
                isLocation = true
                locationManager.startUpdatingLocation()
                locationManager.startMonitoringSignificantLocationChanges()
                break
                
            default:
                break
            }
        } else {
            showDisabledLocationAlert()
        }
    }
    
    private func showMapView() {
        
        let latitude = self.latitude ?? DefaultLocation.Arkhangelsk.latitude
        let longitude = self.longitude ?? DefaultLocation.Arkhangelsk.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 9)
        
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
        mapView.settings.scrollGestures = true
        mapView.delegate = self
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: latitude,
                                                           longitude: longitude))
        
        currentMarker.isDraggable = true
        currentMarker.position.latitude = latitude
        currentMarker.position.longitude = longitude
        currentMarker.map = mapView
        
        view = mapView
    }
    
    private func showDisabledLocationAlert() {
        
        let accessAlert = UIAlertController(title: "Определение местоположения отключено",
                                            message: "Вам необходимо включить определениt местоположения в настройках.",
                                            preferredStyle: .alert)
        
        accessAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL)
        }))
        
        accessAlert.addAction(UIAlertAction(title: "Отмена",
                                            style: .cancel,
                                            handler: nil))
        
        present(accessAlert, animated: true, completion: nil)
    }
    
}

// MARK: - CLLocationManagerDelegate

extension GoogleMapsVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        manager.stopUpdatingLocation()
        
        if isLocation {
            isLocation = false
            
            latitude = coordinate.latitude
            longitude = coordinate.longitude

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showMapView()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.isLocation = true
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

// MARK: GMSMapViewDelegate

extension GoogleMapsVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        latitude = marker.position.latitude
        longitude = marker.position.longitude
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        currentMarker.position = coordinate
        latitude = coordinate.latitude
        longitude = coordinate.longitude
    }
    
}

// MARK: Constants

extension GoogleMapsVC {
    
    struct DefaultLocation {
        private init(){}
        
        struct Arkhangelsk {
            private init(){}
            
            static let latitude = 64.542227
            static let longitude = 40.563143
        }
    }
    
}
