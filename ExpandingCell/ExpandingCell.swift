//
//  ExpandingCell.swift
//  AwesomeChat
//
//  Created by Good Luck on 20/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit


class ExpandingCell: UICollectionViewCell {
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var ScreenView: UIView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Speaker: UILabel!
    
    
    var inspiration: Inspiration? {
        didSet {
            if let inspiration = inspiration {
                ImgView.image = inspiration.backgroundImage
                Title.text = inspiration.title
                Time.text = inspiration.roomAndTime
                Speaker.text = inspiration.speaker
            }
        }
    }
 
    
    /*
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        
        //  let targetSize = CGSize(width: 0, height: 0)
        
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        
        autoLayoutAttributes.frame = autoLayoutFrame
        
        return autoLayoutAttributes
    }
    */
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = ExpandingLayoutConstants.featuredHeight
        let standardHeight = ExpandingLayoutConstants.standardHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        
        ScreenView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        Title.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        Time.alpha = delta
        Speaker.alpha = delta
    }
    
}
