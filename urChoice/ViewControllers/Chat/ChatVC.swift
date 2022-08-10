//
//  ChatVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-04-20.
//

import UIKit
import GrowingTextView
import Alamofire
import AVFoundation
import AVKit
import MobileCoreServices


class ChatVC: UIViewController, UITextViewDelegate, ImagePickerDelegate, SelectedMsgDelegage {
    func selectedMsgs(row: Int) {
        print("")
    }
    
    
//    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var containerview: UIView!
    @IBOutlet weak var audioMsgView: UIView!
    @IBOutlet var recordingTimeLabel: UILabel!
    
    var audioRecorder               : AVAudioRecorder!
    var audioPlayer                 : AVAudioPlayer!
    var meterTimer                  :Timer!
    var isAudioRecordingGranted     : Bool!
    var isRecording                 = false
    var isPlaying                   = false
    
    var chatData = [Chats]()
   
    
    
    
    @IBOutlet weak var deletView        : UIView!
    @IBOutlet weak var sendImg          : UIImageView!
    @IBOutlet weak var newMessageText   : GrowingTextView!
    @IBOutlet weak var tblView          : UITableView!
    var imagePicker                     : ImagePicker!
    var dispatchGroup = DispatchGroup()
    var stTime = Date()
    
    var progressTimer:Timer?
    {
        willSet {
            progressTimer?.invalidate()
        }
    }
    
    var playerStream                    : AVPlayer?
    var playerItem: AVPlayerItem?
    var conversationID                  = String()
    var isChat                          = false
   
    var convID                          = ""
    var reciverID                       = String()
    var selectedIndex                   = Int()
    var otherUserFBID                   = String()
   
    
    var isDeleting                      = false
    var deletingMsgIds                  = Set<String>()
    var player                          = AVPlayer()
    var player1: AVAudioPlayer?
    var chatKey = ""
    let userID = defaults.integer(forKey: "userID")
    var receiverID = ""
    var contactType = ""
    var receiverImgUrl = ""
    let backgroundImage = UIImage(named: "search")
    
    @IBOutlet weak var receiverNameLbl: UILabel!
    @IBOutlet weak var receiverImgVu: UIImageView!
    var receiveImgUrl = ""
    var receiverName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        UIHelper.shared.setImage(address: receiverImgUrl, imgView: receiverImgVu)
        receiverImgVu.layer.borderWidth = 1.0
        receiverImgVu.layer.masksToBounds = false
        receiverImgVu.layer.cornerRadius = receiverImgVu.frame.size.width / 2
        receiverImgVu.clipsToBounds = true
        receiverNameLbl.text = receiverName
        tblView.register(UINib(nibName: "SentMsgCell", bundle: nil), forCellReuseIdentifier: "SentMsgCell")
        tblView.register(UINib(nibName: "RecMsg", bundle: nil), forCellReuseIdentifier: "RecMsg")
        tblView.delegate        = self
        tblView.dataSource      = self
        
        tblView.backgroundColor = UIColor.black
        newMessageText.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
//        deletView.alpha = 0.0
        
        audioMsgView.isHidden = true
        check_record_permission()
        let imageView = UIImageView(image: backgroundImage)
//        tblView.backgroundView = imageView
//        tblView.backgroundView = UIImageView(image: UIImage(named: "search"))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getMessage()
        getchatMessages()
    }
    
    
   
    
    
//    func getMessage(){
//        ProgressHUD.show()
//        self.newMessageText.text = ""
//        Common.shared.getUserFBID(otherUserID: conversationID) { [weak self](key) in
//            guard let self = self else {return}
//            self.otherUserFBID = key
//            Common.shared.getOtherUser(id: key) { (user) in
//                if let user = user{
//                    self.otherFBUser = user
//                    self.chat()
//                }
//            }
//
//        }
//    }
    func getchatMessages(){
        let url     = EndPoint.BASE_URL + "chat/get/" + contactType + "/" + receiverID
        let param   = ["":""]
//        showLoader()
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
//                hideLoader()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: ChatModel = try! JSONDecoder().decode(ChatModel.self, from: jsonData!)
                    if let chats = blogPosts.chats{
                    self.chatData = chats
                        for (index, msg) in chats.enumerated(){
                            if msg.files?.count != 0{
                                let file = msg.files
                                self.chatData[index].messageType = file![0].type!
                            }else{
                                self.chatData[index].messageType = "text"
                            }
                        }
                        self.tblView.reloadData()
                        DispatchQueue.main.async {
                            if self.chatData.count > 1{
                                let indexPath = IndexPath(row: self.chatData.count-1, section: 0)
                                self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                            }
                            
                        }
                    
                    }
                   
                }
                
                
            }else{
//               hideLoader()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    
    
//    func chat(){
//
//        let myString = DEFAULTS.string(forKey: "FBID")! + "___" + self.otherUserFBID
//        chatKey = myString
//        Database.database().reference().child("Chats").observe(.value) { (data) in
//            self.msgs.removeAll()
//            for child in data.children
//            {
//                let msg = child as! DataSnapshot
//                if msg.key == myString{
//                    for a in msg.children{
//                        let innerMsg = a as! DataSnapshot
//                        let val = innerMsg.value! as! [String:Any]
//                        self.msgs.append(FireBaseMessage(deviceType: "\(val["deviceType"] ?? "")",
//                                                         message: "\(val["message"]!)",
//                                                         messageBy: "\(val["messageBy"]!)",
//                                                         recordingTime: "\(val["recordingTime"]!)",
//                                                         seen: "\(val["seen"]!)",
//                                                         time: "\(val["time"]!)",
//                                                         type: "\(val["type"]!)",
//                                                         userId: "\(val["userId"]!)", isSelected: false, messageId: "\(val["messageId"]!)"))
//                    }
//                }
//            }
//            ProgressHUD.dismiss()
//            self.tblView.reloadData()
//            DispatchQueue.main.async {
//                if self.msgs.count > 1{
//                    let indexPath = IndexPath(row: self.msgs.count-1, section: 0)
//                    self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                }
//
//            }
//        }
//    }
    
    
//    func getChatMsgs(){
//        let url = EndPoints.BASE_URL + "conversation/messages?user_match_id=\(conversationID)"
//        let param = ["":""]
//        getWebCall(url: url, params: param, webCallName: "Getting Chat Messages", sender: self) { (response, error) in
//            let messages    = response["messages"]
//            self.messages   = messages
//            let conID       = "\(messages[0]["conversation_id"])"
//            if conID != "null" {
//                self.convID = conID
//            }
//            self.tblView.reloadData()
//        }
//    }
    
//    func getConversationMsgs(){
//        let url = EndPoints.BASE_URL + "conversation/messages?conversation_id=\(conversationID)"
//        let param = ["":""]
//        getWebCall(url: url, params: param, webCallName: "Getting Chat Messages", sender: self) { [unowned self] (response, error) in
//            let messages    = response["messages"]
//            self.messages   = messages
//            self.tblView.reloadData()
//        }
//    }
    
    
    @IBAction func backBtnPressed(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        let text = textView.text!
        if text.count > 0 {
            sendImg.image = UIImage(named: "send")
        }
        else{
            sendImg.image = UIImage(named: "mick")
        }
    }
    
    @IBAction func sendMsgBtn(_ sender: Any)
    {
        let text = newMessageText.text!
        if text.count > 0 {
//            Common.shared.postMsg(msg: text, ohterFBID: otherUserFBID)
            SubmitData(message: newMessageText.text!)
            self.newMessageText.text = ""
        }
        else{
            newMessageText.isUserInteractionEnabled = false
            start_recording()
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any)
    {
        self.imagePicker.present(from: view)
    }
    
    
    func SubmitData(message: String){
//        showLoader()
        let url = EndPoint.BASE_URL + "chat/add-message"
       
        var param = ["type": contactType, "receiver_id" : receiverID,"message": message] as [String : Any]
      
           
        
        postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
              
                let status = String(response["status"] as? Int ?? 404)
                let message = String(response["message"] as? String ?? "Error")
                if status != "200"{
                    self.alert(message: message)
                }else{
                    print("success")
                     let jsonString = jsonToString(jsonTOConvert: response)
                      let jsonData = jsonString.data(using: .utf8)
                     var blogPosts: sendMessageModel = try! JSONDecoder().decode(sendMessageModel.self, from: jsonData!)
                  var chats = blogPosts.chats
                    chats?.messageType = "text"
                    self.chatData.append(chats!)
                    self.tblView.reloadData()
                         DispatchQueue.main.async {
                             if self.chatData.count > 1{
                                 let indexPath = IndexPath(row: self.chatData.count-1, section: 0)
                                 self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                             }
                             
                         }
                     
                     
                    
                }
                
                
            }else{
               
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
    //                self.alert(message: error.description)
            }
        }
        
        
    }
    func submitDataImage(image: UIImage){
       
        let url = EndPoint.BASE_URL + "chat/add-message"
       
        var param = ["type": contactType, "receiver_id" : receiverID,"message": ""] as [String : Any]
       
       
                let data = image.jpegData(compressionQuality: 0.5)
        webCallWithImageWithNameHeader(url: url, parameters: param, webCallName: "edit profile", imgData: data!, imageName: "image", sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        let status = String(response["status"] as? Int ?? 404)
                        let message = String(response["message"] as? String ?? "Error")
                        if status != "200"{
                            self.alert(message: message)
                        }else{
                            print("success")
                             let jsonString = jsonToString(jsonTOConvert: response)
                              let jsonData = jsonString.data(using: .utf8)
                             var blogPosts: sendMessageModel = try! JSONDecoder().decode(sendMessageModel.self, from: jsonData!)
                          var chats = blogPosts.chats
                            chats?.messageType = "image"
                            self.chatData.append(chats!)
                            self.tblView.reloadData()
                                 DispatchQueue.main.async {
                                     if self.chatData.count > 1{
                                         let indexPath = IndexPath(row: self.chatData.count-1, section: 0)
                                         self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                     }
                                     
                                 }
                             
                             
                            
                        }
                       
                    }else{
//                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
   
    func submitDataVideo(videoUrl: URL){
//        showLoader()
        let url = EndPoint.BASE_URL + "chat/add-message"
       
       
        var param = ["type": contactType, "receiver_id" : receiverID,"message": ""] as [String : Any]
       
        let ext = videoUrl.pathExtension
       
        webCallWithVideoHeader(url: url, parameters: param, webCallName: "edit profile",videoUrl: videoUrl,sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        let status = String(response["status"] as? Int ?? 404)
                        let message = String(response["message"] as? String ?? "Error")
                        if status != "200"{
                            self.alert(message: message)
                        }else{
                            print("success")
                             let jsonString = jsonToString(jsonTOConvert: response)
                              let jsonData = jsonString.data(using: .utf8)
                             var blogPosts: sendMessageModel = try! JSONDecoder().decode(sendMessageModel.self, from: jsonData!)
                          var chats = blogPosts.chats
                            chats?.messageType = "video"
                            self.chatData.append(chats!)
                            self.tblView.reloadData()
                                 DispatchQueue.main.async {
                                     if self.chatData.count > 1{
                                         let indexPath = IndexPath(row: self.chatData.count-1, section: 0)
                                         self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                     }
                                     
                                 }
                             
                             
                            
                        }
                       
                    }else{
//                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
    func playAudio(audioMsgUrl: URL){
        let url = audioMsgUrl
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.volume = 1.0
       
        
        //To get overAll duration of the audio
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
       
       
        //To get the current duration of the audio
        let currentDuration : CMTime = playerItem.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
      
        
        player.play()
           
           
            
        }
    func playSound(audioUrl: URL) {
       let url = audioUrl

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player1 = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

         
            player1!.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
       
     
    func submitDataAudio(audioUrl: URL){
//        showLoader()
        let url = EndPoint.BASE_URL + "chat/add-message"
       
        var param = ["type": contactType, "receiver_id" : receiverID,"message": ""] as [String : Any]
       
               
        webCallWithAudioHeader(url: url, parameters: param, webCallName: "audio message", audioUrl: audioUrl, sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        let status = String(response["status"] as? Int ?? 404)
                        let message = String(response["message"] as? String ?? "Error")
                        if status != "200"{
                            self.alert(message: message)
                        }else{
                            print("success")
                             let jsonString = jsonToString(jsonTOConvert: response)
                              let jsonData = jsonString.data(using: .utf8)
                             var blogPosts: sendMessageModel = try! JSONDecoder().decode(sendMessageModel.self, from: jsonData!)
                          var chats = blogPosts.chats
                            chats?.messageType = "audio"
                            self.chatData.append(chats!)
                            self.tblView.reloadData()
                                 DispatchQueue.main.async {
                                     if self.chatData.count > 1{
                                         let indexPath = IndexPath(row: self.chatData.count-1, section: 0)
                                         self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                     }
                                     
                                 }
                             
                             
                            
                        }
                       
                    }else{
//                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
   
    
    
    
}
extension ChatVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return chatData.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if chatData[indexPath.row].sender_id == userID
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentMsgCell") as! SentMsgCell
            cell.configCell(item: chatData[indexPath.row], row: indexPath.row)
            cell.delegate = self
//            cell.contentView.backgroundColor = UIColor.lightGray
            cell.timeLabel.isHidden = false
            if indexPath.row > 0 {
              
                if chatData[indexPath.row - 1].sender_id == userID{
                    cell.heightsToZero.forEach({$0.constant = 0})
                    cell.lblsToClear.forEach({$0.text = ""})
                    cell.viewToHide.forEach({$0.isHidden = true})
                }
                else{
                    cell.heightsToZero.forEach({$0.constant = 0})
                    cell.viewToHide.forEach({$0.isHidden = false})
                }
            }
            else{
                cell.heightsToZero.forEach({$0.constant = 0})
                cell.viewToHide.forEach({$0.isHidden = false})
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecMsg") as! RecMsg
//            if let other = otherFBUser{
//            cell.contentView.backgroundColor = UIColor.lightGray
                cell.configCell(item: chatData[indexPath.row], row: indexPath.row)
                cell.delegate = self
//                
//                                cell.heightsToZero.forEach({$0.constant = 0})
//                                cell.lblsToClear.forEach({$0.text = ""})
//                                cell.viewToHide.forEach({$0.isHidden = true})
                
                
                if indexPath.row > 0 {
                    if chatData[indexPath.row].sender_id == Int(receiverID){
                        cell.heightsToZero.forEach({$0.constant = 0})
                        cell.lblsToClear.forEach({$0.text = ""})
                        cell.viewToHide.forEach({$0.isHidden = true})
                    }
                    else{
                        cell.heightsToZero.forEach({$0.constant = 0})
                        cell.viewToHide.forEach({$0.isHidden = false})
                    }
                }
                else{
                    cell.heightsToZero.forEach({$0.constant = 0})
                    cell.viewToHide.forEach({$0.isHidden = false})
                }
                
//            }
            
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
//        if isDeleting {
//            if deletingMsgIds.count > 0 {
//                if msgs[indexPath.row].isSelected{
//                    msgs[indexPath.row].isSelected = false
//                    deletingMsgIds.remove(msgs[indexPath.row].messageId)
//                }
//                else{
//                    msgs[indexPath.row].isSelected = true
//                    deletingMsgIds.insert(msgs[indexPath.row].messageId)
//                }
//
//            }
//            else {
//
//                deletingMsgIds.removeAll()
//                isDeleting = false
//            }
//
//            if deletingMsgIds.count == 0{
//                self.deletView.alpha = 0.0
//            }
//            tblView.reloadData()
//        }
        
            if chatData[indexPath.row].messageType == "video"{
                playVideo(url: chatData[indexPath.row].files?[0].full_url ?? "")
           
        }
//        tblView.reloadData()

    }
    
//    func deleteMsg()
//    {
//
//        let url = EndPoints.BASE_URL + "delete/message/\(messages[selectedIndex]["id"])"
//        deleteWebCall(url: url, params: ["":""], webCallName: "deleteing Message", sender: self) { [unowned self] (response, error) in
//            if !error
//            {
//                let success = "\(response["success"])"
//                if success == "true"{
//                    self.getMessage()
//                }
//            }
//            else {
//                self.alert(message: API_ERROR)
//            }
//        }
//    }
    
    
    
    func playVideo(url : String){
        guard let videoURL = URL(string: url) else {
            return
        }
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    
//    func selectedMsgs(row: Int) {
//        deleteBtn.isHidden = false
//        if !isDeleting{
//            isDeleting              = true
//            if msgs[row].isSelected{
//                msgs[row].isSelected = false
//            }
//            else{
//                msgs[row].isSelected = true
//            }
//            UIView.animate(withDuration: 0.5) {
//                self.deletView.alpha = 1.0
//            }
//            deletingMsgIds.insert(msgs[row].messageId)
//            tblView.reloadData()
//        }
//
//    }
    
    func video(url: URL?) {
        if let url = url {
           submitDataVideo(videoUrl: url)
//            Common.shared.postMsgWithVideo(url: url, otherFBID: otherUserFBID)
        }
    }
    
    func didSelect(image: UIImage?) {
        if let img = image{
//            Common.shared.postMsgWithImage(img: img, otherFBID: otherUserFBID)
            submitDataImage(image: img)
        }
    }
    
//    @IBAction func deleteMsgs(_ sender: Any) {
//        for key in deletingMsgIds{
//            let myString = DEFAULTS.string(forKey: "FBID")! + "___" + otherUserFBID
//
//            let otherString =  otherUserFBID + "___" + DEFAULTS.string(forKey: "FBID")!
//            Database.database().reference().child("Chats").child(myString).child(key).setValue(nil)
//            Database.database().reference().child("Chats").child(otherString).child(key).setValue(nil)
//        }
//
//                 self.isDeleting = false
//                 self.deletView.isHidden = true
//                 self.deleteBtn.isHidden = true
//        let myString = DEFAULTS.string(forKey: "FBID")! + "___" + otherUserFBID
//         let otherString =  otherUserFBID + "___" + DEFAULTS.string(forKey: "FBID")!
//        self.firstTask { (success) -> Void in
//            if success {
//                // do second task if success
//
//
//
//                let last = self.Lastmsgs.count - 1
//                let lastMessage = self.Lastmsgs[last]
//        if lastMessage.type == "audio"{
//            let lstMsg = ["deviceType":"iOS",
//                          "message":"audio",
//                          "messageBy":"\(DEFAULTS.string(forKey: "FBID")!)",
//                          "recordingTime":0,
//                          "seen":"true",
//                          "time":Date().millisecondsSince1970,
//                          "type":"audio",
//                          "userId":"\(DEFAULTS.string(forKey: "FBID")!)"] as [String : Any]
//            Database.database().reference().child("LastMessages").child(myString).setValue(lstMsg)
//            Database.database().reference().child("LastMessages").child(otherString).setValue(lstMsg)
//        } else if lastMessage.type == "image"{
//            let lstMsg = ["deviceType":"iOS",
//                          "message":"audio",
//                          "messageBy":"\(DEFAULTS.string(forKey: "FBID")!)",
//                          "recordingTime":0,
//                          "seen":"true",
//                          "time":Date().millisecondsSince1970,
//                          "type":"image",
//                          "userId":"\(DEFAULTS.string(forKey: "FBID")!)"] as [String : Any]
//            Database.database().reference().child("LastMessages").child(myString).setValue(lstMsg)
//            Database.database().reference().child("LastMessages").child(otherString).setValue(lstMsg)
//
//        } else if lastMessage.type == "video"{
//            let lstMsg = ["deviceType":"iOS",
//                          "message":"audio",
//                          "messageBy":"\(DEFAULTS.string(forKey: "FBID")!)",
//                          "recordingTime":0,
//                          "seen":"true",
//                          "time":Date().millisecondsSince1970,
//                          "type":"video",
//                          "userId":"\(DEFAULTS.string(forKey: "FBID")!)"] as [String : Any]
//            Database.database().reference().child("LastMessages").child(myString).setValue(lstMsg)
//            Database.database().reference().child("LastMessages").child(otherString).setValue(lstMsg)
//
//        } else if lastMessage.type == "text"{
//
//            Database.database().reference().child("LastMessages").child(myString).setValue(lastMessage)
//            Database.database().reference().child("LastMessages").child(otherString).setValue(lastMessage)
//
//        }
//
//
//            }
//        }
//    }

//    func firstTask(completion: @escaping(_ success: Bool) -> Void) {
//        // Do something
//
//        let myString = DEFAULTS.string(forKey: "FBID")! + "___" + self.otherUserFBID
//        chatKey = myString
//        Database.database().reference().child("Chats").observe(.value) { (data) in
//
//            for child in data.children
//            {
//                let msg = child as! DataSnapshot
//                if msg.key == myString{
//                    for a in msg.children{
//                        let innerMsg = a as! DataSnapshot
//                        let val = innerMsg.value! as! [String:Any]
//                        self.Lastmsgs.append(FireBaseMessage(deviceType: "\(val["deviceType"] ?? "")",
//                                                         message: "\(val["message"]!)",
//                                                         messageBy: "\(val["messageBy"]!)",
//                                                         recordingTime: "\(val["recordingTime"]!)",
//                                                         seen: "\(val["seen"]!)",
//                                                         time: "\(val["time"]!)",
//                                                         type: "\(val["type"]!)",
//                                                         userId: "\(val["userId"]!)", isSelected: false, messageId: "\(val["messageId"]!)"))
//                    }
//                }
//            }
//
//            completion(true)
//    }
//        // Call completion, when finished, success or faliure
//
//    }
}


extension ChatVC: AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    
    func check_record_permission()
    {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSession.RecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
    }
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getFileUrl() -> URL {
        let filename = "myName.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
            }
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Don't have access to use your microphone.", action_title: "OK")
        }
    }
    
    func start_recording()
    {
        if(isRecording)
        {
            newMessageText.isUserInteractionEnabled = false
            isRecording = false
            let endTime = Date()
            let timeIntval = Int(DateInterval(start: stTime, end: endTime).duration * 1000)
//            Common.shared.postMsgWithAudio(url: getFileUrl(), otherFBID: otherUserFBID, recordingTime : "\(timeIntval)")
//            submitDataAudio(audioUrl: getFileUrl())
//            playSound(audioUrl: getFileUrl())
           
            stopRecording()
            finishAudioRecording(success: true)
        }
        else
        {
            stTime = Date()
            sendImg.image = UIImage(named: "send")
            setup_recorder()
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                
                print("Here.a.. ")
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
            }
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            audioMsgView.isHidden = false
//            newMessageText.isUserInteractionEnabled = true
            newMessageText.text = ""
            isRecording = true
        }
    }
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            //            newMessageText.text = totalTimeString
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func finishAudioRecording(success: Bool)
    {
        if success
        {
            newMessageText.isUserInteractionEnabled = true
            submitDataAudio(audioUrl: getFileUrl())
        }
        else
        {
            newMessageText.isUserInteractionEnabled = true
            display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
        }
    }
    
    func prepare_play()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    @IBAction func stopRecordingBtnPressed(_ sender: Any) {
        stopRecording()
    }
    
    func stopRecording() {
        isRecording             = false
        audioRecorder.stop()
        audioRecorder           = nil
        meterTimer.invalidate()
        newMessageText.isUserInteractionEnabled = false
        audioMsgView.isHidden   = true
        sendImg.image           = UIImage(named: "mick")
    }
    
    
    @IBAction func play_recording(_ sender: Any)
    {
        self.imagePicker.present(from: sender as! UIView)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        audioMsgView.isHidden = true
    }
    
    func display_alert(msg_title : String , msg_desc : String ,action_title : String)
    {
        let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: action_title, style: .default)
        {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    
}
