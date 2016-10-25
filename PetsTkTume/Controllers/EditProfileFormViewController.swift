//
//  EditProfileFormViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/25/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class EditProfileFormViewController: UIViewController {

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

    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
