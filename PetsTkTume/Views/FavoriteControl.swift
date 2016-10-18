//
//  FavoriteControl.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/17/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class FavoriteControl: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let button = UIButton()
        
        button.backgroundColor = UIColor.red
        
        button.addTarget(self, action: #selector(FavoriteControl.favoriteButtonTapped(_:)), for: .touchDown)
        
        addSubview(button)
    }
    
    func favoriteButtonTapped(_ button: UIButton) {
       print("sss")
    }
}
