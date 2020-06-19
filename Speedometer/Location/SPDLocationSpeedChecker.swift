//
//  SPDLocationSpeedChecker.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/18/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject

protocol SPDLocationSpeedCheckerDelegate: class {
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker)
}

protocol SPDLocationSpeedChecker: class {
    var delegate: SPDLocationSpeedCheckerDelegate? { get set }
    var maximumSpeed: CLLocationSpeed? { get set }
    var isExceedingMaximumSpeed: Bool { get }
}

class SPDDefaultLocationSpeedChecker {
    weak var delegate: SPDLocationSpeedCheckerDelegate?
    var maximumSpeed: CLLocationSpeed? {
        didSet {
            checkIfSpeedExceeded()
        }
    }
    var isExceedingMaximumSpeed = false {
        didSet {
            delegate?.exceedingMaximumSpeedChanged(for: self)
        }
    }
    var lastLocation: CLLocation?
    let locationProvider: SPDLocationProvider
    
    init(locationProvider: SPDLocationProvider) {
        self.locationProvider = locationProvider
        locationProvider.add(self)
    }
}

private extension SPDDefaultLocationSpeedChecker {
    func checkIfSpeedExceeded() {
        if let maximumSpeed = maximumSpeed, let location = lastLocation {
            isExceedingMaximumSpeed = location.speed > maximumSpeed
        } else {
            isExceedingMaximumSpeed = false
        }
    }
}

extension SPDDefaultLocationSpeedChecker: SPDLocationSpeedChecker {
    
}

extension SPDDefaultLocationSpeedChecker: SPDLocationConsumer {
    func consumeLocation(_ location: CLLocation) {
        lastLocation = location
    }
}

class SPDLocationSpeedCheckerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SPDLocationSpeedChecker.self, factory: { r in
            let locationProvider = r.resolve(SPDLocationProvider.self)!
            return SPDDefaultLocationSpeedChecker(locationProvider: locationProvider)
        }).inObjectScope(.weak)
    }
}

