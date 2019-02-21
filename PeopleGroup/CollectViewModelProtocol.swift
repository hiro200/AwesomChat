//
//  CollectViewModelProtocol.swift
//  AwesomeChat
//
//  Created by Good Luck on 17/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit
//ViewModel chua datasource cho tableView cua View va ham hien thi danh sach product

protocol CollectViewModelProtocol: class {
    var users:[UserInfo]{get}
    
    var userDidChange: ((CollectViewModelProtocol) -> ())? {get set}
    
    
}

class CollectViewModel: CollectViewModelProtocol {
    private(set) var  users: [UserInfo]
    
    var userDidChange: ((CollectViewModelProtocol) -> ())?
    required init(users: [UserInfo]){
        self.users = users
    }
    
    
}



