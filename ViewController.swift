//
//  ViewController.swift
//  AwesomeChat
//
//  Created by Good Luck on 19/01/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AES256CBC
import SwiftyJSON



class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
       
        CollectionView.register(UINib(nibName: "clientCell", bundle: nil), forCellWithReuseIdentifier: "clicell")
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clicell", for: indexPath) as! clientCell
        
        
        
        
        
        
        // get AES-256 CBC encrypted string
        let encrypted_id:String? = AES256CBC.encryptString("kariosrt", password: password)
        let encrypted_name:String? = AES256CBC.encryptString("jojome", password: password)
        
        print("Encrypted ==> \(encrypted_id!)")
        
       // let temp = ["id":"\(encrypted_id!)","name":"\(encrypted_name!)","message":["result":"nice meetyou"]] as [String : Any]
        
        let temp = ["id":"\(encrypted_id!)","name":"\(encrypted_name!)","result":"nice meetyou"] as [String : Any]
        
       // var sem = JSON(temp)
        
       // print("REsult==> \(sem["message"]["result"].stringValue)")
        
        // decrypt AES-256 CBC encrypted string
        // let decrypted = AES256CBC.decryptString(encrypted!, password: password)
        
        //  print("Decrypted ==> \(decrypted)")
        
        Alamofire.request("https://www.revohooah.de/AWSdata.php", method: .post, parameters: temp, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    //let data = response.result.value
                    
                    let jsonData = JSON(data)
                    
                    print(indexPath.row)
                  
                //  print(jsonData[indexPath.row]["result"].stringValue)  //이런 형식으로 값 가져옴
                    
                    
                    //let decrypted_id = AES256CBC.decryptString((jsonData["id"].stringValue), password: password)
                    
                    let decrypted_id = AES256CBC.decryptString((jsonData[indexPath.row]["id"].stringValue), password: password)
                    
                    print("DecrypId ==> \(decrypted_id ?? "dfdf")")
                    
                    print("Good Job")
                    print("DataStr==> \(data)")
                    
                    //let user = User(data :JSONString)
                    
                    //print(user?.id ?? "a")
                    
                    break
                case .failure:
                    print("Fail")
                    break
                }
                
                debugPrint(response)
        }
        
        
        
        return cell
    }
    

    

}

