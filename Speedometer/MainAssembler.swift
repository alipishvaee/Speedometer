//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/19/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembler {
    var resolver: Resolver {
        return assembler.resolver
    }
    private let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)

    init() {
        assembler.apply(assembly: SPDLocationManagerAssembly())
        assembler.apply(assembly: SPDLocationAuthorizationAssembly())
        assembler.apply(assembly: SPDLocationProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedCheckerAssembly())
        assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
        assembler.apply(assembly: ViewControllerAssembly())
    }
}
