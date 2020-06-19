//
//  SPDLocationSpeedProviderDelegateMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Speedometer

class SPDLocationSpeedProviderDelegateMock: SPDLocationSpeedProviderDelegate {
    var lastSpeed: CLLocationSpeed?
    func didUpdate(_ speed: CLLocationSpeed) {
        lastSpeed = speed
    }
    
    
}
