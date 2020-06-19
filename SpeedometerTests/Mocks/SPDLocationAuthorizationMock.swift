//
//  SPDLocationAuthorizationMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationMock: SPDLocationAuthorization {
    weak var delegate: SPDLocationAuthorizationDelegate?
    var didCheckAuthorization = false
    
    func checkAuthorization() {
        didCheckAuthorization = true
    }
    
    
}
