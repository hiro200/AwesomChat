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

    let screenSize = UIScreen.main.bounds
    
    private var initialized = false
    
    private var msg = "asd"
    
    var chatMessages:Array = [""]
    var cellWidth: CGFloat = 0
    
    
   // let columnLayout = FlowLayout()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //tableView 일 경우
    //    tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        /*
        let temp = MessageCell()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let screenWidth = screenSize.width
        layout.itemSize = CGSize(width: 412, height: 100)
        collectView.collectionViewLayout = layout
        collectView.frame.size.width = temp.frame.size.width
         */
        
        
        if let flowLayout = collectView.collectionViewLayout as? UICollectionViewFlowLayout {
            //setNeedsLayout()
           // loadViewIfNeeded()
            
            
            let cell = MessageCell()
            
            
            
            //flowLayout.estimatedItemSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
            
            let layout = collectView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.estimatedItemSize = CGSize(width: 200, height: 30) // your average cell size
          
            
            //flowLayout.estimatedItemSize = CGSize(width: cell.contentView.frame.width, height: cell.contentView.frame.height ) //use auto layout for the collection view
            
            
             collectView.register(UINib(nibName: "MessageCell", bundle: nil), forCellWithReuseIdentifier: "MessageCell")
            
        }
        
 
       
        
        //self.view.addSubview(collectView)
        
    
        socket.connect()
        
        
    
 
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
      //  inputPanelInit()
        
    }
    
    
    
    
    
    /*
    func countLabelLines(label: UILabel) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = label.text! as NSString
        
        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        
        let size = countLabelLines(label: cell.comment)
        let heights = 30 * size
        
        return CGSize(width: cell.contentView.frame.width, height: CGFloat(heights) )
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
    
    
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGRectEdge {
        
        
        if var messageText:String = chatMessages[indexPath.row] {
            
            let size = CGSize(width: view.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estiFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName:UIFont.systemFontSize(18)], context: nil)
            
        }
        
        
        
        
        return  CGRectEdge(view.frame.width,100)
    }
    */
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return chatMessages.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        let currentChatMessage = chatMessages[indexPath.row]
        
        cell.comment.text = currentChatMessage
        
        
        return  cell
    }
    */
    
    
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
    
  
    
    
    // MARK: - Message methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func rcmessage(_ indexPath: IndexPath) -> RCMessage {
        
        return RCMessage()
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
    
    
    // MARK: - Input panel methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func inputPanelInit() {
        
        
        /*
        viewInput.backgroundColor = RCMessages().inputViewBackColor
        textInput.backgroundColor = RCMessages().inputTextBackColor
        
        textInput.font = RCMessages().inputFont
        textInput.textColor = RCMessages().inputTextTextColor
        
        textInput.textContainer.lineFragmentPadding = 0
        textInput.textContainerInset = RCMessages().inputInset
        
        textInput.layer.borderColor = RCMessages().inputBorderColor
        textInput.layer.borderWidth = RCMessages().inputBorderWidth
        
        textInput.layer.cornerRadius = RCMessages().inputRadius
        textInput.clipsToBounds = true
 
        */
        
    }
    
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func inputPanelUpdate() {
        
        let heightView: CGFloat = view.frame.size.height
        let widthView: CGFloat = view.frame.size.width
        
        let leftSafe: CGFloat = view.safeAreaInsets.left
        let rightSafe: CGFloat = view.safeAreaInsets.right
        let bottomSafe: CGFloat = view.safeAreaInsets.bottom
        
        let widthText: CGFloat = textInput.frame.size.width
        var heightText: CGFloat
        let sizeText = textInput.sizeThatFits(CGSize(width: widthText, height: CGFloat.greatestFiniteMagnitude))
        
        
        /*
        heightText = CGFloat.maximum(RCMessages().inputTextHeightMin, sizeText.height)
        heightText = CGFloat.minimum(RCMessages().inputTextHeightMax, heightText)
        
        let heightInput: CGFloat = heightText + (RCMessages().inputViewHeightMin - RCMessages().inputTextHeightMin)
        
        tableView.frame = CGRect(x: leftSafe, y: 0, width: widthView - leftSafe - rightSafe, height: heightView - bottomSafe - heightInput)
 
        
 
        var frameViewInput: CGRect = viewInput.frame
        frameViewInput.origin.y = heightView - bottomSafe - heightInput
        frameViewInput.size.height = heightInput
        viewInput.frame = frameViewInput
        
        viewInput.layoutIfNeeded()
        
        var frameAttach: CGRect = buttonInputAttach.frame
        frameAttach.origin.y = heightInput - frameAttach.size.height
        buttonInputAttach.frame = frameAttach
        
        var frameTextInput: CGRect = textInput.frame
        frameTextInput.size.height = heightText
        textInput.frame = frameTextInput
        
        var frameSend: CGRect = buttonInputSend.frame
        frameSend.origin.y = heightInput - frameSend.size.height
        buttonInputSend.frame = frameSend
        
        buttonInputSend.isEnabled = textInput.text.count != 0
        
        let offset = CGPoint(x: 0, y: sizeText.height - heightText)
        textInput.setContentOffset(offset, animated: false)
        */
     //   scroll(toBottom: false)
    }
    
   
 
    // MARK: - User actions (bubble tap)
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func actionTapBubble(_ indexPath: IndexPath) {
        
    }
    
    // MARK: - User actions (avatar tap)
    //---------------------------------------------------------------------------------------------------------------------------------------------
 
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func buttonInputSend(_ sender: Any) {
        
        if (textInput.text.count != 0) {
            socket.on(clientEvent: .connect) {data, ack in
                print("socket connected")
            }
            
            actionSendMessage(textInput.text)
            dismissKeyboard()
            textInput.text = nil
            inputPanelUpdate()
            
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


