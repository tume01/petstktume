//
//  PetViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/20/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class PetViewController: UIViewController {

    @IBOutlet weak var petNameTextFiled: UITextField!
    @IBOutlet weak var petFamilyNameTextFiled: UITextField!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var newPet: Pet?
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhotoFromLibrary(_ sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func save(_ sender: AnyObject) {
        let userId = SessionManager.sharedInstance().user?.userID
        let petName = petNameTextFiled.text!
        let petFamilyName = petFamilyNameTextFiled.text!
        let petImage = UIImagePNGRepresentation(petImageView.image!)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        (sender as! UIBarButtonItem).customView = activityIndicator
        
        
        PetService.sharedInstance().createPet(userId: userId!, petName: petName, petFamilyName: petFamilyName, petImage: petImage!) {
            networkResult in
            
            DispatchQueue.main.async {
                switch networkResult {
                case .success(let result):
                    self.newPet = result as? Pet
                    self.performSegue(withIdentifier: "unwindSegue", sender: nil)
                case .error:
                    let alertController = UIAlertController(title: "Service Error", message: "Service Error", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        print("you have pressed OK button");
                    }
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                self.activityIndicator.stopAnimating()
                (sender as! UIBarButtonItem).customView = nil
            }
        }
    }
}

extension PetViewController: UITextFieldDelegate {
    
}

extension PetViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        petImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension PetViewController: UINavigationControllerDelegate {
    
}
