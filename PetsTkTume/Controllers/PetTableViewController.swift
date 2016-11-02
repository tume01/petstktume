//
//  PetTableViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/17/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class PetTableViewController: UITableViewController {
    
    @IBOutlet weak var petsLoader: UIActivityIndicatorView!
    var pets: [Pet] = []
    var cachedImages: [String: UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        petsLoader.startAnimating()
        
        PetService.sharedInstance().getPets(userId: (SessionManager.sharedInstance().user?.userID)!) {
            networkResult in
            DispatchQueue.main.async {
                self.petsLoader.stopAnimating()
                
                switch networkResult {
                case .success(let result):
                    self.pets = result as! [Pet]
                    self.tableView.reloadData()
                    
                case .error( _):
                    let alertController = UIAlertController(title: "Service Error", message: "Service Error", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        print("you have pressed OK button");
                    }
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pets.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PetTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PetTableViewCell
        
        let pet = pets[indexPath.row]
        
        if cachedImages[pet.imageURL] != nil {
            cell.petImage.image = cachedImages[pet.imageURL]
        }
        else {
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
        }
        cell.petName.text = pet.name + ", " + pet.family
        cell.favoriteControl.heartButton?.isSelected = pet.isFavorite!
        cell.petId = pet.petId
        
        return cell
    }
    
    
    @IBAction func unwindToPetList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PetViewController {
            let pet = sourceViewController.newPet
            
            self.pets.append(pet!)
            
            let newIndexPath = IndexPath(row: self.pets.count - 1, section: 0)
                
            self.tableView.insertRows(at: [newIndexPath], with: .bottom)
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
