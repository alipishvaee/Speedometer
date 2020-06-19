//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/19/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import Swinject

class MainAssembler {
    var resolver: Resolver {
        return assembler.resolver
    }
    private let assembler = Assembler()

    init() {
        assembler.apply(assembly: SPDLocationManagerAssembly())
        assembler.apply(assembly: SPDLocationAuthorizationAssembly())
        assembler.apply(assembly: SPDLocationProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedCheckerAssembly())
        assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
    }
}
