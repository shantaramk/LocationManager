//
//  ViewController.swift
//  LocationManager
//
//  Created by Shantaram Kokate on 11/20/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupLocationManager()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupLocationManager() {
        LocationManager.shared.locationHandler = { (locationManager, location, error) in
            if error == nil {
                print("Found user's location: \(location!)")
            } else {
                print("Failed to find user's location: \(error!.localizedDescription)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

