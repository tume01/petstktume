//
//  SignUpViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/12/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    
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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
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

}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
