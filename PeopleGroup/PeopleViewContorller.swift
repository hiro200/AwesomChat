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
        
       
        
        
        let viewModel = CollectViewModel(users: users)
        self.viewModel = viewModel
        
        
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
        
        let user = users[indexPath.row]
        
        
        cell.nickname.text = user.nickname
        cell.decrip.text = user.description
        cell.favor.text = user.favor
        
        
        
        return cell
    }
    
    
    
}
