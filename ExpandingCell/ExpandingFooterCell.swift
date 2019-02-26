//
//  ExpandingFooterCell.swift
//  AwesomeChat
//
//  Created by Good Luck on 24/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit





class ExpandingFooterCell: UICollectionViewCell  {
    
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
    //    self.prepareInitialAnimation()
    //    refreshControlIndicator.startAnimating()
        
    }
    
    
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    */
    
    
    func stopIndigate() {
    
        self.refreshControlIndicator.stopAnimating()
    
    }
    
    /*
    func setTransform(inTransform:CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        self.currentTransform = inTransform
        self.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //reset the animation
    func prepareInitialAnimation() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator?.stopAnimating()
        self.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    func startAnimate() {
        self.isAnimatingFinal = true
        self.refreshControlIndicator?.startAnimating()
    }
    
    func stopAnimate() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator?.stopAnimating()
    }
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
    */
    
}
