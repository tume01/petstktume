//
//  ProfileCollectionViewCell.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/21/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    func setCellLayout(profileName: String, email: String, profileImage: UIImage)
    {
        self.nameText.text = profileName
        self.emailText.text = email
        self.profileImage.image = profileImage
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
    }
}
