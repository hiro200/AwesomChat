//
//  TableChatViewController.swift
//  AwesomeChat
//
//  Created by Good Luck on 13/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import Foundation
import UIKit
import SocketIO
import SwiftyJSON



class TableChatViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextViewDelegate {
   
    
    
    
    @IBOutlet var tablesView: UITableView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendText: UIButton!
    
    private var msg = "asd"
    
    var chatMessages:Array = [""]
    var cellWidth: CGFloat = 0
    
   
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
   //     tablesView = UITableView(frame: .zero, style: .plain)
   //     tablesView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        //tableView 일 경우
        tablesView.register(UINib(nibName: "TableMessageCell", bundle: nil), forCellReuseIdentifier: "TableMessageCell")
        
        
        
        
        socket.connect()
        
        
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return UITableView.automaticDimension
    }
    
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tablesView.dequeueReusableCell(withIdentifier: "TableMessageCell", for: indexPath) as! TableMessageCell
        
        
        let currentChatMessage = chatMessages[indexPath.row]
        
     //   let labelWidth = UILabel.textWidth(label: cell.textsView)
        
        cell.textsView.text = currentChatMessage
     
        
        cell.textsView.sizeToFit()
        
        cell.textsView.layer.masksToBounds = true
        cell.textsView.layer.cornerRadius = 10
        
        
        cell.frame =  CGRect(x: 5, y: cell.frame.height+10, width: cell.textsView.frame.width, height: cell.textsView.frame.height)
        
       
        
      //   tablesView.frame = CGRect(x: 0, y: 0, width: width, height: height )
 
    
        
        return cell
    }
    
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        respondMessage()
    }
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        socket.disconnect()
        dismissKeyboard()
    }
    
    
    
    

    
    
    
    
    
    // MARK: - Keyboard methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @objc func keyboardShow(_ notification: Notification?) {
        
        if let info = notification?.userInfo {
            if let keyboard = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let duration = TimeInterval(info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
                UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                    //     self.view.center = CGPoint(x: self.view.center.x ,  y: self.view.center.y - keyboard.size.height + self.view.safeAreaInsets.bottom)
                })
            }
        }
        UIMenuController.shared.menuItems = nil
    }
    
    
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @objc func keyboardHide(_ notification: Notification?) {
        
        if let info = notification?.userInfo {
            let duration = TimeInterval(info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
            UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                //    self.view.center = CGPoint(x: self.view.center.x ,  y: self.view.center.y )
            })
        }
    }
    
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func buttonInputSend(_ sender: Any) {
        
        if (textView.text.count != 0) {
            socket.on(clientEvent: .connect) {data, ack in
                print("socket connected")
            }
            
            actionSendMessage(textView.text)
            dismissKeyboard()
            
            
            textView.text = nil
        }
    }
    
    
    
    func actionSendMessage(_ text: String) {
        
        socket.emit("chat message", text)
        
        
    }
    
    func respondMessage() {
        
        
        socket.on("chat message") { data, ack in
            
            //let jsonData = JSON(data)
            
            self.msg = data[0] as! String
            
            
            self.chatMessages.append(self.msg)
            
            
            
            print("Msg \(self.msg)")
            print("Data Info \(data)")
            self.tablesView.reloadData()
        }
        
    }
    
    
    /*
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return 1
     }
     */
    
    
    
}
