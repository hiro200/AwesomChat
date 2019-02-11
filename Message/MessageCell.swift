//
//  MessageCell.swift
//  AwesomeChat
//
//  Created by Good Luck on 29/01/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//





import Foundation
import UIKit

class MessageCell: UICollectionViewCell {
    
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var AvartaImg: UIImageView!
    @IBOutlet weak var bubbleImg: UIImageView!
    
 //   @IBOutlet weak var widthContrain: NSLayoutConstraint!
    
    
    /*
    class func fromNib() -> MessageCell?
    {
        var cell: MessageCell?
        let nibViews = Bundle.main.loadNibNamed("MessageCell", owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? MessageCell {
                
            
                cell = cellView
            }
        }
        return cell
    }
    */
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        
        autoLayoutAttributes.frame = autoLayoutFrame
        
        return autoLayoutAttributes
    }
    
    
}


