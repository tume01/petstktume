//
//  PetTableViewCell.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/17/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var favoriteControl: FavoriteControl! {
        didSet {
            let iconNo = #imageLiteral(resourceName: "heart-no")
            let iconYes = #imageLiteral(resourceName: "heart-yes")
            
            let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 41, height: 41))
            let iconButton = UIButton(frame: iconSize)
            iconButton.setBackgroundImage(iconNo, for: .normal)
            iconButton.setBackgroundImage(iconYes, for: .selected)
            iconButton.setBackgroundImage(iconYes, for: [.selected, .highlighted])
            iconButton.adjustsImageWhenHighlighted = false
        
            let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(self.setFavorite(sender:)))
            
            iconButton.addGestureRecognizer(tapFavorite)
            favoriteControl.heartButton = iconButton
    
            favoriteControl.addSubview(iconButton)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("inicell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {


        // Configure the view for the selected state
    }
    
    func setFavorite(sender: UITapGestureRecognizer) {
        if (self.favoriteControl.heartButton?.isSelected)! {
            self.favoriteControl.heartButton?.isSelected = false
        }else {
            UIView.animate(withDuration: 0.1 ,
                           animations: {
                            self.favoriteControl.heartButton?.transform = CGAffineTransform(scaleX: 0, y: 0)
                },
                           completion: { finish in
                            UIView.animate(withDuration: 0.2){
                                self.favoriteControl.heartButton?.isSelected = true
                                self.favoriteControl.heartButton?.transform = CGAffineTransform.identity
                            }
            })
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        petImage.image = nil
    }

}
