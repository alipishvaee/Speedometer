//
//  SPDLocationSpeedCheckerDelegateMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationSpeedCheckerDelegateMock: SPDLocationSpeedCheckerDelegate {
    var didChangeExceedingMaxSpeed = false
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker) {
        didChangeExceedingMaxSpeed = true
    }
    
    
}
