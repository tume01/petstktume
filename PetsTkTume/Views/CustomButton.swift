//
//  CustomButton.swift
//  PetsTkTume
//
//  Created by Franco Tume on 11/3/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }

}
