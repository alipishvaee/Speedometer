//
//  SPDLocationConsumerMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Speedometer

class SPDLocationConsumerMock: SPDLocationConsumer {
    var lastLocation: CLLocation?
    func consumeLocation(_ location: CLLocation) {
        lastLocation = location
    }
    
}
