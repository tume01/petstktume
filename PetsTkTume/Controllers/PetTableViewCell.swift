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
    @IBOutlet weak var favoriteButton: FavoriteControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
