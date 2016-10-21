//
//  ProfileCollectionViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/21/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit


enum Cell {
    case profile
    case favoritePet
}

struct Section {
    var cells = [Cell]()
    let cellIdentifier: String
}

class ProfileCollectionViewController: UICollectionViewController {
    
    var sections: [Section] = []
    
    let profileCellIdentifier = "ProfileCollectionViewCell"
    let favoritePetCellIdentifier = "FavoritePetCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(FavoritePetCollectionViewCell.self, forCellWithReuseIdentifier: profileCellIdentifier)
        self.collectionView!.register(ProfileCollectionViewCell.self , forCellWithReuseIdentifier: favoritePetCellIdentifier)
     
        sections.append(Section(cells: [], cellIdentifier: profileCellIdentifier))
        sections.append(Section(cells: [], cellIdentifier: favoritePetCellIdentifier))
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        let cell: UICollectionViewCell
        
        switch section.cells[indexPath.row] {
        case .profile:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCollectionViewCell
            
            cell.backgroundColor = UIColor.red
        case .favoritePet:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoritePetCellIdentifier, for: indexPath) as! FavoritePetCollectionViewCell
            cell.backgroundColor = UIColor.blue
        }
    
        // Configure the cell
    
        return cell
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
