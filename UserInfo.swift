//
//  UserInfo.swift
//  AwesomeChat
//
//  Created by Good Luck on 22/01/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

typealias TSAsset = UIImage.Assets


import Foundation
import UIKit

let password = "djhfkshf=!jfhhkufhkf=jfdkjdkjjkl"

//typealias userInfo = String

struct UserInfo {
    
    var nickname = "a"
    //var age = 1
    var sex = true
    var description = "df"
    var wher = "서울"
    var favor = "S"
    var Mers = "d"
    
}






extension UIImage {
    enum Assets : String {
        case Add_friend_icon_addgroup = "add_friend_icon_addgroup"
        case Add_friend_icon_contacts = "add_friend_icon_contacts"
        case Add_friend_icon_invite = "add_friend_icon_invite"
        case Add_friend_icon_offical = "add_friend_icon_offical"
        case Add_friend_icon_reda = "add_friend_icon_reda"
        case Add_friend_icon_scanqr = "add_friend_icon_scanqr"
        case Back_icon = "back_icon"
        case Barbuttonicon_add = "barbuttonicon_add"
        case Barbuttonicon_add_cube = "barbuttonicon_add_cube"
        case Barbuttonicon_addfriends = "barbuttonicon_addfriends"
        case Barbuttonicon_back = "barbuttonicon_back"
        case Barbuttonicon_back_cube = "barbuttonicon_back_cube"
        case Barbuttonicon_call = "barbuttonicon_call"
        case Barbuttonicon_Camera = "barbuttonicon_Camera"
        case Barbuttonicon_Camera_Golden = "barbuttonicon_Camera_Golden"
        case Barbuttonicon_delete = "barbuttonicon_delete"
        case Barbuttonicon_InfoMulti = "barbuttonicon_InfoMulti"
        case Barbuttonicon_InfoSingle = "barbuttonicon_InfoSingle"
        case Barbuttonicon_Luckymoney = "barbuttonicon_Luckymoney"
        case Barbuttonicon_mini_cube = "barbuttonicon_mini_cube"
        case Barbuttonicon_more = "barbuttonicon_more"
        case Barbuttonicon_more_black = "barbuttonicon_more_black"
        case Barbuttonicon_more_cube = "barbuttonicon_more_cube"
        case Barbuttonicon_Operate = "barbuttonicon_Operate"
        case Barbuttonicon_question = "barbuttonicon_question"
        case Barbuttonicon_set = "barbuttonicon_set"
        case C2cReceiverMsgNodeBG = "c2cReceiverMsgNodeBG"
        case C2cReceiverMsgNodeBG_HL = "c2cReceiverMsgNodeBG_HL"
        case C2cSenderMsgNodeBG = "c2cSenderMsgNodeBG"
        case C2cSenderMsgNodeBG_HL = "c2cSenderMsgNodeBG_HL"
        case Chathistory_detail_end = "chathistory_detail_end"
        case Emoticon_keyboard_magnifier = "emoticon_keyboard_magnifier"
        case Emotion_delete = "emotion_delete"
        case Icon_avatar = "icon_avatar"
        case ReceiverImageNodeBorder = "ReceiverImageNodeBorder"
        case ReceiverImageNodeMask = "ReceiverImageNodeMask"
        case ReceiverTextNodeBkg = "ReceiverTextNodeBkg"
        case ReceiverTextNodeBkgHL = "ReceiverTextNodeBkgHL"
        case ReceiverVoiceNodePlaying = "ReceiverVoiceNodePlaying"
        case ReceiverVoiceNodePlaying001 = "ReceiverVoiceNodePlaying001"
        case ReceiverVoiceNodePlaying002 = "ReceiverVoiceNodePlaying002"
        case ReceiverVoiceNodePlaying003 = "ReceiverVoiceNodePlaying003"
        case MessageTooShort = "MessageTooShort"
        case RecordCancel = "RecordCancel"
        case RecordingBkg = "RecordingBkg"
      
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init!(asset: Assets) {
        self.init(named: asset.rawValue)
    }
}

