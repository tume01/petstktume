//
//  LandingViewController.swift
//  PetsTkTume
//
//  Created by Franco Tume on 11/3/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let landingPageViewController = segue.destination as? LandingPageViewController {
            landingPageViewController.landingDelegate = self
        }
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

extension LandingViewController: LandingPageViewControllerDelegate {
    
    func landingPageViewController(_ landingPageViewController: LandingPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func landingPageViewController(_ landingPageViewController: LandingPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
