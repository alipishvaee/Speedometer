//
//  SPDLocationAuthorizationDelegateMock.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/20/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationDelegateMock: SPDLocationAuthorizationDelegate {
    
    var authorizationWasDenied = false
    func authorizationDenied(for locationAuthorization: SPDLocationAuthorization) {
        authorizationWasDenied = true
    }
    
    
}
