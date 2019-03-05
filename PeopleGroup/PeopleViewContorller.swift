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



protocol SendDataDelegate {
    
    func sendData(_ controller: PeopleViewContorller , data: [UserInfo])
    
}


class PeopleViewContorller: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var users = [ // model
        UserInfo(nickname: "koko", sex: true, description:"hi there", wher: "Seoul", favor: "S", Mers: "dse"),
        UserInfo(nickname: "nana", sex: false, description:"hi there", wher: "Seoul", favor: "S", Mers: "dse")
    ]
    
    
    var delegate: SendDataDelegate?
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
        let refreshControl = UIRefreshControl()
       
        
        let viewModel = CollectViewModel(users: users)
        self.viewModel = viewModel
        
        
        
        if #available(iOS 10.0, *) {
            MyCollectionView.refreshControl = refreshControl
        } else {
            MyCollectionView.addSubview(refreshControl)
        }
        
        
      
        
        let bundle = Bundle(for: self.classForCoder)
        
        MyCollectionView.register(UINib(nibName: "PeopleCell", bundle: bundle), forCellWithReuseIdentifier: "PeopleCell")
        
        
    }
    
    
    var viewModel: CollectViewModelProtocol! {
        didSet {
            self.viewModel.userDidChange = { [unowned self] viewModel in
                
                self.MyCollectionView.reloadData()
            }
        }
    }
    
    
    
   /*
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goViewController" {
            
            let destinations : ViewController = (segue.destination as? ViewController)!
           // destinations.userData = users
           // delegate?.sendData(data: users)
            destinations.delegates = self.delegate as? ViewController
            
        }
        
    }
    
   */
    
    
    
    
    //  코드로 셀 갯수 정하는거
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath) as! PeopleCell
        
        if (indexPath.row == 2 ) {
            cell.nickname.text = nil
            cell.decrip.text = "Load...."
            cell.favor.text = nil
            
        }
        else {
            let user = users[indexPath.row]
            cell.nickname.text = user.nickname
            cell.decrip.text = user.description
            cell.favor.text = user.favor
        }
        
    
        return cell
    }
    
    
    
    // cell click
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if  indexPath.row == 1 {
            
            print("Loading Success")
            
            
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goViewController"  {
            
            let destinations  = segue.destination as? ViewController
        
            destinations?.userData = users
            
        }
        
    }
    
    
    
    @IBAction func DataSend(_ sender: Any) {
        
        if delegate != nil {
            delegate?.sendData(self, data: users)
         //   dismiss(animated: true, completion: nil)
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




