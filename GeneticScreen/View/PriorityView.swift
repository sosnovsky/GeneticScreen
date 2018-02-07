//
//  PriorityView.swift
//  GeneticScreen
//
//  Created by Roma Sosnovsky on 8/2/16.
//  Copyright © 2016 Roma Sosnovsky. All rights reserved.
//

import UIKit

class PriorityView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tickView: UIImageView!
    @IBOutlet weak var activeTickView: UIImageView!
    
    var isSelected = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    
    func xibSetup() {
        UINib(nibName: String(describing: type(of: self)), bundle: Bundle.main).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions.alignAllCenterY , metrics: nil, views: ["view": self.view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions.alignAllCenterX , metrics: nil, views: ["view": self.view]))
        
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
    }
    
    func setData(_ text: String, imageName: String) {
        imageView.image = UIImage(named: imageName)
        textLabel.text = text
        textLabel.sizeToFit()
    }
    
    func toggleSelected() -> Bool {
        isSelected = !isSelected
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions(), animations: {
            if self.isSelected {
                self.activeTickView.frame = self.tickView.frame
            } else {
                let frameCenter = self.activeTickView.frame.getCenterPoint()
                self.activeTickView.frame = CGRect(origin: frameCenter, size: CGSize(width: 0, height: 0))
            }
            
        }, completion: nil)

        return isSelected
    }
}
