//
//  AppDelegate.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/17/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import UIKit
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
    let mainAssembler = MainAssembler()
    let locationAuthorization: SPDLocationAuthorization
    
    override init() {
        locationAuthorization = mainAssembler.resolver.resolve(SPDLocationAuthorization.self)!
        super.init()
        locationAuthorization.delegate = self
    }
}

private extension AppDelegate {
    func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let storybaord = SwinjectStoryboard.create(name: "Main", bundle: nil)
        window.backgroundColor = .black
        window.rootViewController = storybaord.instantiateInitialViewController()
        self.window = window
    }
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        locationAuthorization.checkAuthorization()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}



extension AppDelegate: SPDLocationAuthorizationDelegate {
    func authorizationDenied(for locationAuthorization: SPDLocationAuthorization) {
        let alertController = UIAlertController(title: "Permission Denied", message: "Speedometer needs permission to work properly.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

