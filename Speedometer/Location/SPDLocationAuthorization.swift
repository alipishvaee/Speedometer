//
//  SPDLocationAuthorization.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/18/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation


extension NSNotification.Name {
    static let SPDLocationAuthorized = NSNotification.Name("NSNotification.Name.SPDLocationAuthorized")
}

protocol SPDLocationAuthorizationDelegate: class {
    func authorizationDenied( for locationAuthorization: SPDLocationAuthorization)
}


protocol SPDLocationAuthorization: class {
    var delegate: SPDLocationAuthorizationDelegate? { get set }
    
    func checkAuthorization()
    
}

class SPDDefaultLocationAuthorization {
    weak var delegate: SPDLocationAuthorizationDelegate?
    let locationManager: SPDLocationManager
    
    init(locationManager: SPDLocationManager) {
        self.locationManager = locationManager
        locationManager.authorizationDelegate = self
    }
    
}

extension SPDDefaultLocationAuthorization: SPDLocationAuthorization {
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

extension SPDDefaultLocationAuthorization: SPDLocationManagerAuthorizationDelegate {
    func locationManager(_ manager: SPDLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            NotificationCenter.default.post(name: .SPDLocationAuthorized, object: self)
        case .denied, .restricted:
            delegate?.authorizationDenied(for: self)
        default:
            break
        }
    }
    
    
}
