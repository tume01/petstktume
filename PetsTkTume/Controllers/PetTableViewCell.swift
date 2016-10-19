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
    @IBOutlet weak var favoriteControl: FavoriteControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("inicell")
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(PetTableViewCell.setFavorite(sender:)))
        
        favoriteControl.addGestureRecognizer(tapFavorite)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorite(sender: UITapGestureRecognizer) {
        print("tabbb")
    }

}
