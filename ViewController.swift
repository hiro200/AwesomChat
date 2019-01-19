//
//  ViewController.swift
//  AwesomeChat
//
//  Created by Good Luck on 19/01/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clicell", for: indexPath) as! clientCell
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

