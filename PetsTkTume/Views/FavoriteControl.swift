//
//  FavoriteControl.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/17/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class FavoriteControl: UIView {
    
    var heartButton: UIButton?
    var petId: Int?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animateHeart(state : Bool) {
        UIView.animate(withDuration: 0.1 ,
                       animations: {
                        self.heartButton?.transform = CGAffineTransform(scaleX: 0, y: 0)
            },
                       completion: { finish in
                        UIView.animate(withDuration: 0.2){
                            self.heartButton?.isSelected = state
                            self.heartButton?.transform = CGAffineTransform.identity
                        }
        })
    }
}
