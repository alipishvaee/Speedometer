//
//  ViewController.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/17/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import UIKit
import CoreLocation
import Swinject
import SwinjectStoryboard


private let maxDisplayableSpeed: CLLocationSpeed = 40 // M/S or 144 KM/H

class ViewController: UIViewController {

    var speedProvider: SPDLocationSpeedProvider! {
        didSet {
            speedProvider.delegate = self
        }
    }
    var speedChecker: SPDLocationSpeedChecker! {
        didSet {
            speedChecker.delegate = self
        }
    }
    
    @IBOutlet var speedLabels: [UILabel]!
    @IBOutlet weak var speedViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var colorableViews: [UIView]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in speedLabels {
            label.text = "0"
        }
        speedViewHeightConstraint.constant = 0
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func didTapMaxSpeed(_ sender: Any) {
        let alertController = UIAlertController(title: "Pick a max speed", message: "You will be alerted when you exceed this max speed.", preferredStyle: .alert)
        alertController.addTextField { [weak self] (textField) in
            textField.keyboardType = .asciiCapableNumberPad
            if let maxSpeed = self?.speedChecker.maximumSpeed {
                textField.text = String(format: "%.0f", maxSpeed.asKMH)
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (ـ) in
            guard let text = alertController.textFields?.first?.text else { return }
            guard let maxSpeed = Double(text) else { return }
            self?.speedChecker.maximumSpeed = maxSpeed.asMPS
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController: SPDLocationSpeedProviderDelegate {
    func didUpdate(_ speed: CLLocationSpeed) {
        for label in speedLabels {
            label.text = String(format: "%.0f", speed.asKMH)
        }
        view.layoutIfNeeded()
        
        let maxHeight = view.bounds.height
        speedViewHeightConstraint.constant = maxHeight * CGFloat(speed / maxDisplayableSpeed)
        
        UIView.animate(withDuration: 1.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

extension ViewController: SPDLocationSpeedCheckerDelegate {
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker) {
        let color: UIColor = speedChecker.isExceedingMaximumSpeed ? .speedometerRed : UIColor.black
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            for view in self?.colorableViews ?? [] {
                if let label = view as? UILabel {
                    label.textColor = color
                } else if let button = view as? UIButton {
                    button.setTitleColor(color, for: .normal)
                } else {
                    view.backgroundColor = color
                }
            }
        }
    }
}

extension UIColor {
    static let speedometerRed = UIColor(red: 255/255, green: 82/255, blue: 0/255, alpha: 1)
}

extension Double {
    var asMPS: CLLocationSpeed {
        return self / 3.6  // 3.6 KM/H = 1 M/S
    }
}
extension CLLocationSpeed {
    var asKMH: Double {
        return self * 3.6 // 1 M/S = 3.6 KM/H
    }
}

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.storyboardInitCompleted(ViewController.self) { (r, c) in
            c.speedProvider = r.resolve(SPDLocationSpeedProvider.self)!
            c.speedChecker = r.resolve(SPDLocationSpeedChecker.self)!
        }
        
    }
}
