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
    var petId: Int?
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {


        // Configure the view for the selected state
    }
    
    func setFavorite(sender: UITapGestureRecognizer) {
        let state = !self.favoriteControl.heartButton!.isSelected
        
        PetService.sharedInstance().setFavoritePet(userId: (SessionManager.sharedInstance().user?.userID)!, petId: self.petId!, isFavorite: state) {
            networkResult in
            DispatchQueue.main.async {
                switch networkResult {
                case .success:
                    self.favoriteControl.animateHeart(state: state)
                case .error:
                    let alertController = UIAlertController(title: "Wrong Credentials", message: "Wrong Credentials", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        print("you have pressed OK button");
                    }
                    alertController.addAction(OKAction)
                    
                    //self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        petImage.image = nil
    }

}
