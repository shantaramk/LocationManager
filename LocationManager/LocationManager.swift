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
    
    // MARK: - Internal Properties
    
    static let shared = LocationManager()
    var locationManager: CLLocationManager = CLLocationManager()
    var locationHandler: ((CLLocationManager, CLLocation?, Error?) -> Void)?
    
    // MARK: - Init
    
    override init() {
        super.init()
        self.checkLocationService()
    }
    
    // MARK: - SetUp
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.requestAlwaysAuthorization()
    }
    
    func checkLocationService() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            if checkLocationAuthorization() {
                locationManager.startUpdatingLocation()
            } else {
            }
        } else {
            showLocationSettingPage()
        }
    }
    
    func checkLocationAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
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
        
        guard let location = locations.first else {
            return
        }
        locationHandler!(manager, location, nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationHandler!(manager, nil, error)
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
        
        //Refer : https://github.com/shantaramk/Custom-Alert-View
        /*
         let alertView = AlertView(title: LocalizedStrings.locationService, message: LocalizedStrings.locationAccessMessage, okButtonText: LocalizedStrings.gotoSettting, cancelButtonText: AlertMessage.Cancel) { (_, button) in
         if button == .other {
         UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
         }
         }
         alertView.show(animated: true) */
        print("Goto Setting->app->Location->status")
    }
}
