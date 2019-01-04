//
//  LocationManager.swift
//  LocationManager
//
//  Created by Shantaram Kokate on 11/20/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
class LocationManager: NSObject {
    
    // MARK: - Properties
    
    var locationManager: CLLocationManager!
    var locationHandler: ((CLLocationManager, Error?) -> Void)?
    
    // MARK: - Init
    
    override init() {
        super.init()
        self.setupLocationManager()
    }
    
    // MARK: - SetUp
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.requestAlwaysAuthorization()
    }
    
    func checkLocationService() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            if checkLocationAuthorization() {
                locationManager.startUpdatingLocation()
            }
        } else {
            showLocationSettingPage()
        }
    }
    
    func checkLocationAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            //updateGoogleMapUsingLocation(locationManager.location!)
            return true
        case .denied:
            showLocationSettingPage()
            return false
        case .notDetermined:
            return false
        case .restricted:
            return false
        case .authorizedAlways:
            return true
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let location = locations.first {
            print("Found user's location: \(location)")
        }
        locationHandler!(manager, nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        locationHandler!(manager, error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
        } else {
            if locationManager.location != nil {
                locationManager.startUpdatingLocation()
            }
        }
        
    }
}

// MARK: - Private Methods

extension LocationManager {
    func showLocationSettingPage () {
        /*
         let alertView = AlertView(title: LocalizedStrings.locationService, message: LocalizedStrings.locationAccessMessage, okButtonText: LocalizedStrings.gotoSettting, cancelButtonText: AlertMessage.Cancel) { (_, button) in
         if button == .other {
         UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
         }
         }
         alertView.show(animated: true) */
    }
}
