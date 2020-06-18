//
//  SPDLocationManager.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/17/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation

protocol SPDLocationManagerDelegate: class {
    func locationManager(_ manager: SPDLocationManager, didUpdateLocations locations: [CLLocation])
    
}

protocol SPDLocationManagerAuthorizationDelegate: class {
    func locationManager(_ manager: SPDLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
}

protocol SPDLocationManager: class {
    var delegate: SPDLocationManagerDelegate? { get set }
    var authorizationDelegate: SPDLocationManagerAuthorizationDelegate? { get set }
    var authorizationStatus: CLAuthorizationStatus { get }
    
    func requestWhenInUseAuthorization()
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

class SPDLocationManagerProxy: NSObject {
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    
    let locationManager: CLLocationManager
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
    }
}

extension SPDLocationManagerProxy: SPDLocationManager {
    
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension SPDLocationManagerProxy: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationManager(self, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationDelegate?.locationManager(self, didChangeAuthorization: status)
    }
}

