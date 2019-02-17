//
//  ChatViewController.swift
//  AwesomeChat
//
//  Created by Good Luck on 12/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
import MessageKit
import Photos



let manager = SocketManager(socketURL: URL(string: "https://www.revohooah.de/socketio-chat")!, config: [.log(true), .compress])
let socket = manager.defaultSocket


/*

class ChatViewController: MessagesViewController, UITextViewDelegate {
    
    
    
    @IBOutlet var textInput: UITextView!
    @IBOutlet var buttonInputSend: UIButton!
    @IBOutlet var viewInput: UIView!
    
    
    
    private var msg = "asd"
    var chatMessages:Array = [""]
    
    
    
   
   
    
    
    private var isSendingPhoto = false {
        didSet {
            DispatchQueue.main.async {
                self.messageInputBar.leftStackViewItems.forEach { item in
                //    item.isEnabled = !self.isSendingPhoto
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
        
            
            
            
            maintainPositionOnKeyboardFrameChanged = true
            messageInputBar.inputTextView.tintColor = .primary
            messageInputBar.sendButton.setTitleColor(.primary, for: .normal)
            
          
            messagesCollectionView.messagesDataSource = self as! MessagesDataSource
            messagesCollectionView.messagesLayoutDelegate = self as! MessagesLayoutDelegate
            messagesCollectionView.messagesDisplayDelegate = self as! MessagesDisplayDelegate
        
    }
        
    
    
    
    
    
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
            self.chatMessages.sort()
            
            
            let isLatestMessage = self.chatMessages.index(of: self.msg) == (self.chatMessages.count - 1)
            let shouldScrollToBottom = self.messagesCollectionView.isAtBottom && isLatestMessage
            
            self.messagesCollectionView.reloadData()
            
            
            
            if shouldScrollToBottom {
                DispatchQueue.main.async {
                    self.messagesCollectionView.scrollToBottom(animated: true)
                }
            }
            
            
            print("Msg \(self.msg)")
            print("Data Info \(data)")
         //   self.collectView.reloadData()
            
        }
        
    }
    
    
}





// MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .primary : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
}



// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    
}



// MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {
    
    

    func currentSender() -> Sender {
        return Sender(id: user.uid,displayName: AppSettings.displayName)
    }
    
    
    
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.chatMessages.count
    }
    
    
   
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.chatMessages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.chatMessages[indexPath.section] as! MessageType
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
}


*/



// MARK: - UIImagePickerControllerDelegate
/*
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let asset = info[.phAsset] as? PHAsset { // 1
            let size = CGSize(width: 500, height: 500)
            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { result, info in
                guard let image = result else {
                    return
                }
                
             //   self.sendPhoto(image)
            }
        } else if let image = info[.originalImage] as? UIImage { // 2
          //  sendPhoto(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
*/
