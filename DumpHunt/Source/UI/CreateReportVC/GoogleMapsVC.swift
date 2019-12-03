//
//  GoogleMapsVC.swift
//  DumpHunt
//
//  Created by Serik on 22.11.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapsVC: BaseVC {
    
    var mapView = GMSMapView()
    var currentMarker = GMSMarker()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seyMapView()
    }
    
    func seyMapView() {
        
        let latitude = Utill.latitude ?? DefaultLocation.Moscow.latitude
        let longitude = Utill.longitude ?? DefaultLocation.Moscow.longitude
        
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
}


// MARK: GMSMapViewDelegate

extension GoogleMapsVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }

    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        Utill.latitude = marker.position.latitude
        Utill.longitude = marker.position.longitude
        Utill.printInTOConsole(">> didEndDragging- \(marker.position)")
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        currentMarker.position = coordinate
        Utill.latitude = coordinate.latitude
        Utill.longitude = coordinate.longitude
        Utill.printInTOConsole(">>>>>> didLongPressAt- \(coordinate)")
    }

}


// MARK: Constants

extension GoogleMapsVC {
    
    struct DefaultLocation {
        private init(){}

        struct Moscow {
               private init(){}
               
               static let latitude = 55.75
               static let longitude = 37.48
           }
    }
    
}
