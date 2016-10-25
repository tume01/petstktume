//
//  OverlayView.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/25/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class OverlayView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var view: UIView!

    class func loadViewFromXibFile() -> OverlayView {
        return Bundle.main.loadNibNamed("OverlayView", owner: nil, options: nil)!.first as! OverlayView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
        self.backgroundColor = UIColor.clear
        
        let view = Bundle.main.loadNibNamed("OverlayView", owner: nil, options: nil)!.first as! OverlayView
        
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        translatesAutoresizingMaskIntoConstraints = false
    
        /// Adds a shadow to our view
        view.layer.cornerRadius = 4.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        
        visualEffectView.layer.cornerRadius = 4.0
    }

    func displayView(onView: UIView) {
        self.alpha = 0.0
        self.frame = onView.bounds
        
        onView.addSubview(self)
        
        onView.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: onView, attribute: .centerY, multiplier: 1.0, constant: -80.0)) // move it a bit upwards
        onView.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: onView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        onView.needsUpdateConstraints()
        
        // display the view
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alpha = 1.0
            self.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
           
        }
    }
    @IBAction func removeOverLay(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alpha = 0.0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (finished) -> Void in
            
        }
    }
}
