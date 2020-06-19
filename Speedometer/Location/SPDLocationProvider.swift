//
//  SPDLocationProvider.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/18/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject


protocol SPDLocationConsumer: class {
    func consumeLocation( _ location: CLLocation)
}

protocol SPDLocationProvider: class {
    func add(_ consumer: SPDLocationConsumer)
}

class SPDDefaultLocationProvider {
    let locationManager: SPDLocationManager
    let locationAuthorization: SPDLocationAuthorization
    
    var locationConsumers = [SPDLocationConsumer]()
    
    init(locationManager: SPDLocationManager, locationAuthorization: SPDLocationAuthorization) {
        self.locationManager = locationManager
        self.locationAuthorization = locationAuthorization
        locationManager.delegate = self
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

private extension SPDDefaultLocationProvider {
    func setupNotifications() {
        NotificationCenter.default.addObserver(forName: .SPDLocationAuthorized, object: locationAuthorization, queue: .main) { [weak self] (_) in
            self?.locationManager.startUpdatingLocation()
        }
    }
}
extension SPDDefaultLocationProvider: SPDLocationProvider {
    func add(_ consumer: SPDLocationConsumer) {
        locationConsumers.append(consumer)
    }
}

extension SPDDefaultLocationProvider: SPDLocationManagerDelegate {
    func locationManager(_ manager: SPDLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sortedLocations = locations.sorted { (lhs, rhs) -> Bool in
            return lhs.timestamp.compare(rhs.timestamp) == .orderedDescending
        }
        guard let location = sortedLocations.first else { return }
        
        for consumer in locationConsumers {
            consumer.consumeLocation(location)
        }
    }
}

class SPDLocationProviderAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SPDLocationProvider.self, factory: { r in
            let locationManager = r.resolve(SPDLocationManager.self)!
            let locationAuthorization = r.resolve(SPDLocationAuthorization.self)!
            return SPDDefaultLocationProvider(locationManager: locationManager, locationAuthorization: locationAuthorization)
        }).inObjectScope(.weak)
    }
}
