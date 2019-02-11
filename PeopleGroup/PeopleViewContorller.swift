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
    
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        MyCollectionView.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "PeopleCell")
        
        
    }
    
    
    
    //  코드로 셀 갯수 정하는거
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath) as! PeopleCell
        
        
        
        return cell
    }
    
    
    
}
