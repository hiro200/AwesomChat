//
//  ExpandingController.swift
//  AwesomeChat
//
//  Created by Good Luck on 20/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit



class ExpandingController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var ExpandCollectionView: UICollectionView!
    
    
    
    let inspirations = Inspiration.allInspirations()
    private let refreshControl = UIRefreshControl()
    var isLoading:Bool = false
    
    var temp:Int!
    
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
        
        
      //  self.ExpandCollectionView.register(UINib(nibName: "ExpandingFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ExpandingFooterView")
        
        
      //  ExpandCollectionView.register(UINib(nibName: "ExpandingFooterCell", bundle: nil),  forCellWithReuseIdentifier: "ExpandingFooterCell")
        
        ExpandCollectionView.register(UINib(nibName: "ExpandingCell", bundle: nil), forCellWithReuseIdentifier: "ExpandingCell")
        
        
        
       refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...", attributes: nil)
        
        
       
        
        
        temp = inspirations.count - 3
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
    
    /*
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        if indexPath.row == temp - 4 {
            // loadMoreData()
            let cells = ExpandCollectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingFooterCell", for: indexPath) as! ExpandingFooterCell
            
            cells.refreshControlIndicator.stopAnimating()
            
            print("Refresh Success")
            
         //   temp += 2
            
          //  self.ExpandCollectionView.reloadData()
        }
        
    }
    */
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
    
        /*
        if indexPath.row == temp - 4{
            // return the new UICollectionViewCell with an activity indicator
            let cells = ExpandCollectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingFooterCell", for: indexPath) as! ExpandingFooterCell
            
            return cells
        }
        */
        
        let cell = ExpandCollectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingCell", for: indexPath) as! ExpandingCell
        
        cell.inspiration = inspirations[indexPath.item]
        
        
        return cell
    }
    
    /***************************** 컬렉션뷰 헤더 선언 및 리턴 ******************************/
    /*
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        var footer: ExpandingFooterView?
        if kind == UICollectionView.elementKindSectionHeader {
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterView", for: indexPath) as? ExpandingFooterView
            
            
        }
        return footer!
    }
 */
    /***************************** 컬렉션뷰 헤더 선언 및 리턴 ******************************/
  
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterView", for: indexPath) as! ExpandingFooterView
            
            self.footerView = aFooterView
            
            return aFooterView
            
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterView", for: indexPath)
            return headerView
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.prepareInitialAnimation()
        }
    }
    */
    
   
    
    
    
    
    
    
}
