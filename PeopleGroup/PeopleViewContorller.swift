//
//  PeopleViewContorller.swift
//  AwesomeChat
//
//  Created by Good Luck on 22/01/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import UIKit
import Foundation
//import Alamofire
//import AES256CBC
//import SwiftyJSON

class PeopleViewContorller: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let users = [ // model
        UserInfo(nickname: "koko", sex: true, description:"hi there", wher: "Seoul", favor: "S", Mers: "dse"),
        UserInfo(nickname: "nana", sex: false, description:"hi there", wher: "Seoul", favor: "S", Mers: "dse")
    ]
    
    
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
        let refreshControl = UIRefreshControl()
        var isLoading:Bool = false
        
        
        let viewModel = CollectViewModel(users: users)
        self.viewModel = viewModel
        
        
        
        if #available(iOS 10.0, *) {
            MyCollectionView.refreshControl = refreshControl
        } else {
            MyCollectionView.addSubview(refreshControl)
        }
        
        
        /*
        MyCollectionView.register(UINib(nibName: "ExpandingFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ExpandingFooterView")
        */
        
        
        MyCollectionView.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "PeopleCell")
        
        
    }
    
    
    var viewModel: CollectViewModelProtocol! {
        didSet {
            self.viewModel.userDidChange = { [unowned self] viewModel in
                
                self.MyCollectionView.reloadData()
            }
        }
    }
    
    
    
    //  코드로 셀 갯수 정하는거
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath) as! PeopleCell
        
        if (indexPath.row == 2 ) {  }
        else {
            let user = users[indexPath.row]
            cell.nickname.text = user.nickname
            cell.decrip.text = user.description
            cell.favor.text = user.favor
        }
        
        
        
        
        if indexPath.row == 2 {
            
            cell.nickname.text = nil
            cell.decrip.text = "Load...."
            cell.favor.text = nil
            
        }
        
        
        return cell
    }
    
    
    // cell click
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if  indexPath.row == 2 {
            
            print("Loading Success")
            
        }
        
    }
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterView", for: indexPath) as! ExpandingFooterView
            
            
            
            return aFooterView
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandingFooterCell", for: indexPath)
            return headerView
        }
    }
    
    */
    
    
    
}
