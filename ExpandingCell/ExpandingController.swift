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
        
        
        ExpandCollectionView.register(UINib(nibName: "ExpandingFooterCell", bundle: nil),  forCellWithReuseIdentifier: "ExpandingFooterCell")
        
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
        
        
        return temp
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        if indexPath.item == inspirations.count - 4 {
            // loadMoreData()
          //  let ser = ExpandingFooterCell()
           // ser.refreshControlIndicator.stopAnimating()
            
         //   temp += 2
            
          //  self.ExpandCollectionView.reloadData()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
    
        
        if indexPath.item == inspirations.count - 4{
            // return the new UICollectionViewCell with an activity indicator
            let cells = ExpandCollectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingFooterCell", for: indexPath) as! ExpandingFooterCell
            
            return cells
        }
        
        
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
    
    /*
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.stopAnimate()
        }
    }
    
    
    
    //compute the scroll value and play witht the threshold to get desired effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold   = 100.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold  = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold   =  min(triggerThreshold, 0.0)
        let pullRatio  = min(abs(triggerThreshold),1.0);
        self.footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
        if pullRatio >= 1 {
            self.footerView?.animateFinal()
        }
        print("pullRation:\(pullRatio)")
    }
    
    
    
    //compute the offset and call the load method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = abs(diffHeight - frameHeight);
        print("pullHeight:\(pullHeight)");
        if pullHeight == 0.0
        {
            if (self.footerView?.isAnimatingFinal)! {
                print("load more trigger")
                self.isLoading = true
                self.footerView?.startAnimate()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer:Timer) in
                    for i:Int in self.inspirations.count + 1...self.inspirations.count + 25 {
                        //self.items.append(i)
                    }
                    self.ExpandCollectionView.reloadData()
                    self.isLoading = false
                })
            }
        }
    }
    */
    
    
    
    
    
    
}
