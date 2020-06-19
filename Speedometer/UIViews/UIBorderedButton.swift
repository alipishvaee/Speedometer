//
//  UIBorderedButton.swift
//  Speedometer
//
//  Created by Ali Pishvaee on 6/19/20.
//  Copyright © 2020 AliPishvaee. All rights reserved.
//

import UIKit

@IBDesignable
class UIBorderedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = titleLabel?.textColor.cgColor
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
}
