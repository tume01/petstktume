//
//  ProfileCollectionViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/21/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit


enum Cell {
    case profile(cell: User)
    case favoritePet(cell: Pet)
}

struct Section {
    var cells = [Cell]()
    let cellIdentifier: String
}

class ProfileCollectionViewController: UICollectionViewController {
    
    var sections: [Section] = []
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let profileCellIdentifier = "ProfileCollectionViewCell"
    let favoritePetCellIdentifier = "FavoritePetCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfileCell()
        loadFavoritePets()
    }
    
    func loadFavoritePets() {
        let user = SessionManager.sharedInstance().user!
        
        PetService.sharedInstance().getFavoritePets(userId: user.userID) {
            serviceResult in
            DispatchQueue.main.async {
                switch serviceResult {
                case .success(let pets):
                    let favoritePets = pets as? [Pet]
                    var cells:[Cell] = []
                    
                    favoritePets?.forEach {
                        pet in
                        
                        cells.append(Cell.favoritePet(cell: pet))
                    }
                    
                    self.sections.append(Section(cells: cells, cellIdentifier: self.favoritePetCellIdentifier))
                    self.collectionView?.reloadData()
                case .error:
                    print("error petfavorite")
                }
            }
        }
    }
    
    func loadProfileCell() {
        let user = SessionManager.sharedInstance().user!
        sections.append(Section(cells: [Cell.profile(cell: user)], cellIdentifier: profileCellIdentifier))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for 8segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sections[section].cells.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let section = sections[indexPath.section]
        print(indexPath.section)
        
        
        switch section.cells[indexPath.row] {
        case .profile(let sectionCell):
            var cell: ProfileCollectionViewCell
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCollectionViewCell
            
            cell.nameText.text = sectionCell.firstName
            cell.emailText.text = sectionCell.email
           
            return cell
            
        case .favoritePet(let sectionCell):
            var cell: FavoritePetCollectionViewCell
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoritePetCellIdentifier, for: indexPath) as! FavoritePetCollectionViewCell
            
            let pet = sectionCell
            
            NetworkManager.sharedInstance().getDataFromUrl(url: URL(string: pet.imageURL)!) {
                networkResult in
                
                switch networkResult {
                case .error:
                    print("error")
                case .success(let result):
                    let imageData = result as? Data
                    
                    if let image = UIImage(data: imageData!) {
                        cell.petImage.image = image
                    }
                }
            }
            
            cell.petName.text = pet.name
            
            return cell
        }
    
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension ProfileCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = sections[indexPath.section]
        
        switch section.cells[indexPath.row] {
        case .profile:
            return CGSize(width: collectionView.frame.size.width, height: 300)
        case .favoritePet:
            return CGSize(width: 100, height: 100)
        }
    }
}
