//
//  SPDLocationAuthorizationTests.swift
//  SpeedometerTests
//
//  Created by Ali Pishvaee on 6/24/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import XCTest
@testable import Speedometer
class SPDLocationAuthorizationTests: XCTestCase {

    var sut: SPDLocationAuthorization!
    var locationManagerMock: SPDLocationManagerMock!
    var delegateMock: SPDLocationAuthorizationDelegateMock!
    
    override func setUp() {
        super.setUp()
        locationManagerMock = SPDLocationManagerMock()
        delegateMock = SPDLocationAuthorizationDelegateMock()
        
        sut = SPDDefaultLocationAuthorization(locationManager: locationManagerMock)
        sut.delegate = delegateMock
    }

    func test_checkAuthorization_notDetermined_requestsAuthorization() {
//        Arrange
        locationManagerMock.authorizationStatus = .notDetermined
//        Act
        sut.checkAuthorization()
//        Assert
        XCTAssertTrue(locationManagerMock.requestedWhenInUseAuthorization)
    }
    
    func test_checkAuthorization_determined_doesNotRequestsAuthorization() {
        
    }
    
    func test_didChangeAuthorizationStatus_authorizedWhenInUse_notificationIsPosted() {
        
    }
    
    func test_didChangeAuthorizationStatus_authorizedAlways_notificationIsPosted() {
        
    }
    
    func test_didChangeAuthorizationStatus_denied_delegateInformed() {
        
    }
    
    func test_didChangeAuthorizationStatus_restricted_delegateInformed() {
        
    }
    
}
