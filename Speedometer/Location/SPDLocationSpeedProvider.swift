//
//  SPDLocationSpeedProvider.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/18/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation

protocol SPDLocationSpeedProviderDelegate: class {
    func didUpdate(_ speed: CLLocationSpeed)
}

protocol SPDLocationSpeedProvider: class {
    var delegate: SPDLocationSpeedProviderDelegate? { get set }
}

class SPDDefaultLocationSpeedProvider {
    let locationProvider: SPDLocationProvider
    weak var delegate: SPDLocationSpeedProviderDelegate?
    
    init(locationProvider: SPDLocationProvider) {
        self.locationProvider = locationProvider
        locationProvider.add(self)
    }
}

extension SPDDefaultLocationSpeedProvider: SPDLocationSpeedProvider {
    
}

extension SPDDefaultLocationSpeedProvider: SPDLocationConsumer {
    func consumeLocation(_ location: CLLocation) {
        let speed = max(location.speed,0)
        delegate?.didUpdate(speed)
    }
}
