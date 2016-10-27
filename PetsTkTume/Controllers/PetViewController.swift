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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePet(_ sender: AnyObject) {
        
        let userId = SessionManager.sharedInstance().user?.userID
        let petName = petNameTextFiled.text!
        let petFamilyName = petFamilyNameTextFiled.text!
        let petImage = UIImagePNGRepresentation(petImageView.image!)
        
        PetService.sharedInstance().createPet(userId: userId!, petName: petName, petFamilyName: petFamilyName, petImage: petImage!) {
            networkResult in
            
            DispatchQueue.main.async {
                switch networkResult {
                case .success(let result):
                    let newPet = result as! Pet
                    print(newPet)
                case .error(let error):
                    print("error")
                }
                
            }
        }
    }
    
    @IBAction func selectPhotoFromLibrary(_ sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
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
