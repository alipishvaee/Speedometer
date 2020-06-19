//
//  SPDLocationManagerMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Speedometer

class SPDLocationManagerMock: SPDLocationManager {
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var requestedWhenInUseAuthorization = false
    var didStartUpdatingLocation = false
    var didStopUpdatingLocation = false
    
    func requestWhenInUseAuthorization() {
        requestedWhenInUseAuthorization = true
    }
    
    func startUpdatingLocation() {
        didStartUpdatingLocation = true
    }
    
    func stopUpdatingLocation() {
        didStopUpdatingLocation = true
    }
    
    
}
