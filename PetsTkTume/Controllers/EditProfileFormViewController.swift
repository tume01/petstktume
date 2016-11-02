//
//  EditProfileFormViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/25/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class EditProfileFormViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = SessionManager.sharedInstance().user?.firstName
        userEmail.text = SessionManager.sharedInstance().user?.email
        lastName.text = SessionManager.sharedInstance().user?.lastName
        
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

    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveProfile(_ sender: AnyObject) {
        let newUserName = userName.text
        let newLastName = lastName.text
        let newUserEmail = userEmail.text
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        (sender as! UIBarButtonItem).customView = activityIndicator
        
        ProfileService.sharedInstance().editProfile(userId: (SessionManager.sharedInstance().user?.userID)!, newName: newUserName!, newLastName: newLastName!, newEmail: newUserEmail!) {
            networkResult in
            
            DispatchQueue.main.async {
                switch networkResult {
                case .success(let result):
                    if let updatedUser = result as? User {
                        SessionManager.sharedInstance().user = updatedUser
                        self.user = updatedUser
                        self.activityIndicator.stopAnimating()
                        self.performSegue(withIdentifier: "unwindToProfile", sender: nil)
                    }
                    
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
