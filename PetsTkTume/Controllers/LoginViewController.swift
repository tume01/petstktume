//
//  LoginViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/12/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginLoader: UIActivityIndicatorView!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerToEvents()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func registerToEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        let keyboardHeight = keyboardRectangle.height
        
        loginButtonBottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.5, delay: 0.0000001, options : [.curveEaseInOut, .transitionCurlDown,] , animations: {
            
            self.view.layoutIfNeeded()
        })
        
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0000001, options : [.curveEaseInOut, .transitionCurlDown,] , animations: {
            self.loginButtonBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func login(_ sender: UIButton) {
        
        loginLoader.startAnimating()
        loginButton.isEnabled = false
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let userCredentials = [
            "email": userNameTextField.text!,
            "password": passwordTextField.text!
        ]
        
        SessionService.sharedInstance().login(credentials: userCredentials) {
            networkResult in
            DispatchQueue.main.async {
                
                self.loginLoader.stopAnimating()
                switch networkResult {
                case .success( _):
                    guard let window = UIApplication.shared.delegate?.window! else {
                        return
                    }
                    
                    let mainStoryboad = UIStoryboard(name: "Main", bundle: nil)
                    let snapshotView = window.snapshotView(afterScreenUpdates: false)

                    window.rootViewController = mainStoryboad.instantiateInitialViewController()
                    
                    window.addSubview(snapshotView!)
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        snapshotView?.alpha = 0
                        }, completion: { (_) in
                            snapshotView?.removeFromSuperview()
                    })
                    
                    
                case .error( _):
                    let alertController = UIAlertController(title: "Wrong Credentials", message: "Wrong Credentials", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        print("you have pressed OK button");
                    }
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
                self.loginButton.isEnabled = true
            }
        }
        
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
