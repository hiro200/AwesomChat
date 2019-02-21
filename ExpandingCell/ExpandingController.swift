//
//  ExpandingController.swift
//  AwesomeChat
//
//  Created by Good Luck on 20/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit


class ExpandingController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    
    
    @IBOutlet weak var ExpandCollectionView: UICollectionView!
    
    let inspirations = Inspiration.allInspirations()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        if let layout = ExpandCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            // layout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
            layout.estimatedItemSize = CGSize(width: 375, height: 80) // your average cell size
            
 
        }
    */
        
        ExpandCollectionView.register(UINib(nibName: "ExpandingCell", bundle: nil), forCellWithReuseIdentifier: "ExpandingCell")
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = ExpandCollectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingCell", for: indexPath) as! ExpandingCell
        
        cell.inspiration = inspirations[indexPath.item]
        return cell
    }
    
    
    
    
    
}
