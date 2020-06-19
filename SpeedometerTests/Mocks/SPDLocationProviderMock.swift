//
//  SPDLocationProviderMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationProviderMock: SPDLocationProvider {
    var lastConsumer: SPDLocationConsumer?
    func add(_ consumer: SPDLocationConsumer) {
        lastConsumer = consumer
    }
    
    
}
