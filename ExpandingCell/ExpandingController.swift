//
//  ExpandingController.swift
//  AwesomeChat
//
//  Created by Good Luck on 20/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit
//import PullToRefreshKit


class ExpandingController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    
    
    @IBOutlet weak var ExpandCollectionView: UICollectionView!
    
    let inspirations = Inspiration.allInspirations()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        if let layout = ExpandCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            // layout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
            layout.estimatedItemSize = CGSize(width: 375, height: 80) // your average cell size
            
 
        }
    */
        
        
        if #available(iOS 10.0, *) {
            ExpandCollectionView.refreshControl = refreshControl
        } else {
            ExpandCollectionView.addSubview(refreshControl)
        }
        
        ExpandCollectionView.register(UINib(nibName: "ExpandingFooterCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ExpandingFooterCell")
        
        ExpandCollectionView.register(UINib(nibName: "ExpandingCell", bundle: nil), forCellWithReuseIdentifier: "ExpandingCell")
        
        
        
       refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...", attributes: nil)
    }
    
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    
    private func fetchWeatherData() {
        
                self.refreshControl.endRefreshing()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = ExpandCollectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingCell", for: indexPath) as! ExpandingCell
        
        cell.inspiration = inspirations[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = ExpandCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterCell", for: indexPath) as! ExpandingFooterCell
            
            
            
            return aFooterView
        } else {
            let headerView = ExpandCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterCell", for: indexPath)
            return headerView
        }
    }
    
    
    
}
