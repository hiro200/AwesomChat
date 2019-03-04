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
    
   
    
}
