//
//  ChattingViewController.swift
//  AwesomeChat
//
//  Created by Good Luck on 28/01/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//



import Foundation
import UIKit
import SocketIO
import SwiftyJSON



let manager = SocketManager(socketURL: URL(string: "https://www.revohooah.de/socketio-chat")!, config: [.log(true), .compress])
let socket = manager.defaultSocket

// let jsonURLString:String = "https://www.revohooah.de/socketio-chat/?token=ABCD777"


class ChattingViewController:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate, UITextViewDelegate, UICollectionViewDelegateFlowLayout {
   

    
    
    @IBOutlet var collectView: UICollectionView!
    @IBOutlet var buttonInputAttach: UIButton!
    @IBOutlet var textInput: UITextView!
    @IBOutlet var buttonInputSend: UIButton!
    @IBOutlet var viewInput: UIView!

  
    
    private var msg = "asd"
    
    var chatMessages:Array = [""]
    var cellWidth: CGFloat = 0
    
    
   // let columnLayout = FlowLayout()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //tableView 일 경우
    //    tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
       
    
            
        
        if let layout = collectView.collectionViewLayout as? UICollectionViewFlowLayout {
           
            // layout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
            layout.estimatedItemSize = CGSize(width: 300, height: 30) // your average cell size
          
            
             collectView.register(UINib(nibName: "MessageCell", bundle: nil), forCellWithReuseIdentifier: "MessageCell")
            
        }
        
 
     
    
        socket.connect()
        
        
    
 
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
        for familyName in UIFont.familyNames {
            print("========\(familyName)===========")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(fontName)
            }
        }
        
        
        
        
    }
    
    
    
    
    
   
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         let cell = collectView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
       
        
        let text = chatMessages[indexPath.row]
        let width = UILabel.textWidth(font: UIFont.init(name: "Copperplate-Bold", size: 24)! , text: text)
        return CGSize(width: width, height: 30)
    }
    */
 
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
       
        
        let currentChatMessage = chatMessages[indexPath.row]
        
        cell.comment.text = currentChatMessage
     //   cell.comment.preferredMaxLayoutWidth = 70
     //   cell.comment.frame = cell.contentView.frame
        
        
        
        print("SizeW == \(cell.comment.frame.width)")
        print("SizeH == \(cell.comment.frame.height)")
        
        
        
        return  cell
    }
    
    
    
    
   
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
  
  
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
            if (info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) != nil {
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
        
        if (textInput.text.count != 0) {
            socket.on(clientEvent: .connect) {data, ack in
                print("socket connected")
            }
            
            actionSendMessage(textInput.text)
            dismissKeyboard()
            textInput.text = nil
            
            
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
            self.collectView.reloadData()
        }
        
    }
  
    
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    */
    
    /*
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        /*
        
        if (indexPath.row == 0) {
            return RCSectionHeaderCell.height(indexPath, messagesView: self)
        }
        
        if (indexPath.row == 1) {
            return RCBubbleHeaderCell.height(indexPath, messagesView: self)
        }
        
        if (indexPath.row == 2) {
            
            let rcmessage = self.rcmessage(indexPath)
            if (rcmessage.type == RC_TYPE_STATUS)    { return RCStatusCell.height(indexPath, messagesView: self)                }
            if (rcmessage.type == RC_TYPE_TEXT)        { return RCTextMessageCell.height(indexPath, messagesView: self)        }
            if (rcmessage.type == RC_TYPE_EMOJI)    { return RCEmojiMessageCell.height(indexPath, messagesView: self)        }
            if (rcmessage.type == RC_TYPE_PICTURE)    { return RCPictureMessageCell.height(indexPath, messagesView: self)        }
            if (rcmessage.type == RC_TYPE_VIDEO)    { return RCVideoMessageCell.height(indexPath, messagesView: self)        }
            if (rcmessage.type == RC_TYPE_AUDIO)    { return RCAudioMessageCell.height(indexPath, messagesView: self)        }
            if (rcmessage.type == RC_TYPE_LOCATION)    { return RCLocationMessageCell.height(indexPath, messagesView: self)    }
        }
        
        if (indexPath.row == 3) {
            return RCBubbleFooterCell.height(indexPath, messagesView: self)
        }
        
        if (indexPath.row == 4) {
            return RCSectionFooterCell.height(indexPath, messagesView: self)
        }
 
 
        */
 
        return 0
    }
    */
  
  
}


extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
}

