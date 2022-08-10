//
//  ContactsVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit
import Lottie
import ContactsUI
import PhoneNumberKit

class ContactsVC: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var searchOuterVu: UIView!
    @IBOutlet weak var tbvu: UITableView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var globeAnimatedVu: AnimationView!
    @IBOutlet weak var friemdsAnimatedVu: AnimationView!
    @IBOutlet weak var SCROLLvU: UIScrollView!
    @IBOutlet weak var genderBtn: UIButton!
    
    @IBOutlet weak var index0Vu: UIView!
    
    @IBOutlet weak var animatedOuterVu: UIView!
    @IBOutlet weak var index3Vu: UIView!
    @IBOutlet weak var index2Vu: UIView!
    @IBOutlet weak var index1Vu: UIView!
    var urChoiceFriends = [Friends]()
    var receivedRequests = [ReceivedFriendRequests]()
    var pendingRequests = [PendingFriendRequests]()
    var type: contactModeltype?
    
//    private Contacs
    var phoneContacts = [PhoneContact]()
    var filter: ContactsFilter = .none
    var phoneNumber = [String]()
    var phoneNumbersWithCountryCode = [String]()
    let phoneNumberKit = PhoneNumberKit()
    var privateContactsData = [lastMessageChat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVu()
        setuptbVu()
        tbvu.delegate = self
        tbvu.dataSource = self
        tbvu.allowsSelection = false
       
       
        
        
       
        // Do any additional setup after loading the view.
    }
    func setuptbVu(){
        tbvu.register(UINib(nibName: "ContactsTVC", bundle: nil), forCellReuseIdentifier: "ContactsTVC")
        tbvu.register(UINib(nibName: "LastMessageCell", bundle: nil), forCellReuseIdentifier: "LastMessageCell")
        tbvu.separatorStyle = .none
        tbvu.backgroundColor = UIColor.black
        tbvu.allowsSelection = false
    }
    func setupVu(){
        searchTxtField.delegate = self
        searchOuterVu.layer.borderWidth = 1
        searchOuterVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        animatedOuterVu.layer.borderWidth = 1
        animatedOuterVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        index0Vu.isHidden = false
        index1Vu.isHidden = true
        index2Vu.isHidden = true
        index3Vu.isHidden = true
        friemdsAnimatedVu.animationSpeed = 0.5
        friemdsAnimatedVu.loopMode = .playOnce
        globeAnimatedVu.animationSpeed = 0.5
        globeAnimatedVu.loopMode = .playOnce
        friemdsAnimatedVu.play()
        globeAnimatedVu.play()
        searchTxtField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont(name:"FreeMono",size:14)
        ])
        searchTxtField.textColor = UIColor.white
       
//        genderBtn.setImage(UIImage(named: "message"), for: .normal)
    
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchContactsVC") as? SearchContactsVC
        vc?.searchText = searchTxtField.text!
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        type = contactModeltype.urChoiceContacts
        index0Vu.isHidden = true
        index1Vu.isHidden = false
        index2Vu.isHidden = true
        index3Vu.isHidden = true
        type = contactModeltype.urChoiceContacts
        genderBtn.setImage(UIImage(named: "male2"), for: .normal)
        getFriendsData()
    }

    @IBAction func segmentControlBtnTpd(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            index0Vu.isHidden = false
            index1Vu.isHidden = true
            index2Vu.isHidden = true
            index3Vu.isHidden = true
            type = contactModeltype.privateFrieds
            genderBtn.setImage(UIImage(named: "message"), for: .normal)
            hideLoader()
            getLastMessageContacts()
            
//            let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "PrivateContactsVC") as? PrivateContactsVC
//
//            self.navigationController?.pushViewController(vc!, animated: true)
        case 1:
            index0Vu.isHidden = true
            index1Vu.isHidden = false
            index2Vu.isHidden = true
            index3Vu.isHidden = true
            type = contactModeltype.urChoiceContacts
            genderBtn.setImage(UIImage(named: "male2"), for: .normal)
            hideLoader()
            getFriendsData()
        case 2:
            index0Vu.isHidden = true
            index1Vu.isHidden = true
            index2Vu.isHidden = false
            index3Vu.isHidden = true
            type = contactModeltype.received
            genderBtn.setImage(UIImage(named: "male2"), for: .normal)
            hideLoader()
            getReceivedRequestsData()
        case 3:
            index0Vu.isHidden = true
            index1Vu.isHidden = true
            index2Vu.isHidden = true
            index3Vu.isHidden = false
            type = contactModeltype.requests
            genderBtn.setImage(UIImage(named: "male2"), for: .normal)
            hideLoader()
            getPendingRequestsData()
            
        default:
            print("any")
        }
    }
    
    func privateContacts(){
        tbvu.register(UINib(nibName: "PrivateContactsTVC", bundle: nil), forCellReuseIdentifier: "PrivateContactsTVC")
        tbvu.separatorStyle = .none
        tbvu.delegate = self
        tbvu.dataSource = self
        tbvu.backgroundColor = UIColor.black
        self.firstTask { (success) -> Void in
            if success {
                let phoneNumbers = phoneNumberKit.parse(phoneNumber)
                
                for contact in phoneNumbers{
                    phoneNumberKit.format(contact, toType: .e164)
                    let num =  phoneNumberKit.format(contact, toType: .e164)
                    phoneNumbersWithCountryCode.append(num)

                }
                SubmitData()
            }}
    }
   
    @IBAction func genderBtnTpd(_ sender: UIButton) {
        if type == contactModeltype.privateFrieds{
            let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PrivateContactsVC") as? PrivateContactsVC
           
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
        genderBtn.isSelected.toggle()
        if genderBtn.isSelected{
            genderBtn.setImage(UIImage(named: "female2"), for: .normal)
        }else{
            genderBtn.setImage(UIImage(named: "male2"), for: .normal)
        }
        }
    }
    @IBAction func settingBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getFriendsData(){
        let url     = EndPoint.BASE_URL + "user/get-friends"
        let param   = ["":""]
        showLoader()
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               hideLoader()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: FriendsModel = try! JSONDecoder().decode(FriendsModel.self, from: jsonData!)
                    if let friends = blogPosts.friends{
                        self.urChoiceFriends = friends
                    }
                   
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
                hideLoader()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func getReceivedRequestsData(){
        let url     = EndPoint.BASE_URL + "user/get-friend-requests/"
        let param   = ["":""]
        showLoader()
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
                hideLoader()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: ReceivedFriendsRequestModel = try! JSONDecoder().decode(ReceivedFriendsRequestModel.self, from: jsonData!)
                    if let friends = blogPosts.friendRequests{
                        self.receivedRequests = friends
                    }
                   
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
               hideLoader()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func getPendingRequestsData(){
        let url     = EndPoint.BASE_URL + "user/get-pending-friend-requests"
        let param   = ["":""]
        showLoader()
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
                hideLoader()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: PendingRequests = try! JSONDecoder().decode(PendingRequests.self, from: jsonData!)
                    if let friends = blogPosts.pendingFriendRequests{
                        self.pendingRequests = friends
                    }
                   
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
               hideLoader()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func getLastMessageContacts(){
        let url     = EndPoint.BASE_URL + "chat/get/private"
        let param   = ["":""]
        showLoader()
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
                hideLoader()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: lastMsgContacs = try! JSONDecoder().decode(lastMsgContacs.self, from: jsonData!)
                    if let msgs = blogPosts.chats{
                        self.privateContactsData.removeAll()
                        self.privateContactsData = msgs
                    }
                   
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
               hideLoader()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func SubmitData(isAccept: Bool, userId: String, tag: Int, comefromPending: Bool){
        let url     = EndPoint.BASE_URL + "user/friend-request"

       
        var param = ["interests": ""]
        if isAccept{
            param = ["id": userId, "type": "accept_request"]
        }else{
            param = ["id": userId, "type": "cancel_request"]
        }
           
           
        showLoader()
        postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               hideLoader()
                let status = String(response["status"] as? Int ?? 404)
                let message = String(response["message"] as? String ?? "Error")
                if status != "200"{
                    self.alert(message: message)
                }else{
                  showSnackBarGray(message: message)
                    if comefromPending{
                        pendingRequests.remove(at: tag)
                    }else{
                    receivedRequests.remove(at: tag)
                    }
                    tbvu.reloadData()
                    
                    
                  
                    
                }
                
                
            }else{
                hideLoader()
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
//                self.alert(message: error.description)
            }
        }
        
    }
}



extension ContactsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .urChoiceContacts:
            return urChoiceFriends.count
        case .received:
            return receivedRequests.count
        case .requests:
           return pendingRequests.count
        case .privateFrieds:
            return privateContactsData.count
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch type {
        
        case .urChoiceContacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTVC", for: indexPath) as! ContactsTVC
            cell.contentView.backgroundColor = UIColor.black
            let friend = urChoiceFriends[indexPath.row]
            cell.buttonsOuterVu.isHidden = true
            cell.messageOuterVu.isHidden = false
            cell.titleLbl.text = friend.friend_user_fullname
            UIHelper.shared.setImage(address: friend.friend_user_img_url ?? "", imgView: cell.profileImgVu)
            cell.msgBtn.tag = indexPath.row
            cell.msgBtn.addTarget(self, action: #selector(msgBtnTpd(sender:)), for: .touchUpInside)
            return cell
        case .received:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTVC", for: indexPath) as! ContactsTVC
            cell.contentView.backgroundColor = UIColor.black
            let friend = receivedRequests[indexPath.row]
            cell.acceptBtn.isHidden = false
            cell.messageOuterVu.isHidden = true
            cell.buttonsOuterVu.isHidden = false
            cell.titleLbl.text = friend.reaction_user_fullname
            UIHelper.shared.setImage(address: friend.reaction_user_img_url ?? "", imgView: cell.profileImgVu)
            cell.acceptBtn.addTarget(self, action: #selector(acceptBtnTpd(sender:)), for: .touchUpInside)
            cell.acceptBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(delBtnTpd(sender:)), for: .touchUpInside)
            return cell
        case .requests:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTVC", for: indexPath) as! ContactsTVC
            cell.contentView.backgroundColor = UIColor.black
            let friend = pendingRequests[indexPath.row]
            cell.messageOuterVu.isHidden = true
            cell.buttonsOuterVu.isHidden = false
            cell.titleLbl.text = friend.user_fullname
            UIHelper.shared.setImage(address: friend.user_img_url ?? "", imgView: cell.profileImgVu)
            cell.acceptBtn.isHidden = true
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(cancelBtnTpd(sender:)), for: .touchUpInside)
            return cell
        case .privateFrieds:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "LastMessageCell", for: indexPath) as! LastMessageCell
            cell1.contentView.backgroundColor = UIColor.black
            cell1.nameLbl.text = privateContactsData[indexPath.row].user_fullname
            UIHelper.shared.setImage(address: privateContactsData[indexPath.row].user_image_url ?? "", imgView: cell1.profileImgVu)
            UIHelper.shared.setImage(address: privateContactsData[indexPath.row].user_flag_url ?? "", imgView: cell1.flagImgVu)
            cell1.msgLbl.text = privateContactsData[indexPath.row].user_message
            cell1.timestampLbl.text = privateContactsData[indexPath.row].updated_at
            cell1.msgBtn.tag = indexPath.row
            cell1.msgBtn.addTarget(self, action: #selector(messageBtnTpd(sender:)), for: .touchUpInside)
          
            return cell1
            
        default:
            print("")
            return UITableViewCell()
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    @objc func acceptBtnTpd(sender: UIButton){
       
        let buttonTag = sender.tag
        let id = receivedRequests[buttonTag].id ?? 0
        SubmitData(isAccept: true, userId: String(id), tag: buttonTag, comefromPending: false)
        
    }
    @objc func messageBtnTpd(sender: UIButton){
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
        vc?.receiverID = String(privateContactsData[sender.tag].user_id ?? 0)
        vc?.contactType = "private"
            vc?.receiverImgUrl = privateContactsData[sender.tag].user_image_url ?? ""
            vc?.receiverName = privateContactsData[sender.tag].user_fullname ?? ""
       self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func delBtnTpd(sender: UIButton){
       
        let buttonTag = sender.tag
        let id = receivedRequests[buttonTag].id ?? 0
        SubmitData(isAccept: false, userId: String(id), tag: buttonTag, comefromPending: false)
        
    }
    @objc func msgBtnTpd(sender: UIButton){
        if type == contactModeltype.urChoiceContacts{
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
            vc?.receiverID = String(urChoiceFriends[sender.tag].user_id ?? 0)
        vc?.contactType = "personal"
            vc?.receiverImgUrl = urChoiceFriends[sender.tag].user_img_url ?? ""
            vc?.receiverName = urChoiceFriends[sender.tag].friend_user_fullname ?? ""
       self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    @objc func cancelBtnTpd(sender: UIButton){
       
        let buttonTag = sender.tag
        let id = pendingRequests[buttonTag].id ?? 0
        SubmitData(isAccept: false, userId: String(id), tag: buttonTag, comefromPending: true)
        
    }
}
// Mark- Private Contacts
extension ContactsVC{
    func firstTask(completion: (_ success: Bool) -> Void) {
        self.loadContacts(filter: filter)
        completion(true)
    }
    
    fileprivate func loadContacts(filter: ContactsFilter) {
         phoneContacts.removeAll()
         var allContacts = [PhoneContact]()
         for contact in PhoneContacts.getContacts(filter: filter) {
             allContacts.append(PhoneContact(contact: contact))
         }

         var filterdArray = [PhoneContact]()
         if self.filter == .mail {
             filterdArray = allContacts.filter({ $0.email.count > 0 }) // getting all email
         } else if self.filter == .message {
             filterdArray = allContacts.filter({ $0.phoneNumber.count > 0 })
         } else {
             filterdArray = allContacts
         }
         phoneContacts.append(contentsOf: filterdArray)

for contact in phoneContacts {
   print("Name -> \(contact.name)")
   print("Email -> \(contact.email)")
   print("Phone Number -> \(contact.phoneNumber)")
    let phone = contact.phoneNumber[0]
    phoneNumber.append(phone)
    
 }
 let arrayCode  = self.phoneNumberWithContryCode()
 for codes in arrayCode {
   print(codes)
 }
 
         }
     
    
    func phoneNumberWithContryCode() -> [String] {

        let contacts = PhoneContacts.getContacts() // here calling the getContacts methods
        var arrPhoneNumbers = [String]()
        for contact in contacts {
            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
                if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
                    let countryCode = fulMobNumVar.value(forKey: "countryCode")
                       if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
                            arrPhoneNumbers.append(MccNamVar)
                    }
                }
            }
        }
        return arrPhoneNumbers // here array has all contact numbers.
    }
  
    func SubmitData(){
        let url     = EndPoint.BASE_URL + "user/get-user-from-contact-list"
        var selectedIndexArray = [String]()
        for index in phoneNumbersWithCountryCode{
            if selectedIndexArray.count == 0{
                let replaced = index.replacingOccurrences(of: " ", with: "")
                selectedIndexArray.append(replaced)
            }else{
                selectedIndexArray.append(",")
                let replaced = index.replacingOccurrences(of: " ", with: "_")
                selectedIndexArray.append(replaced)
            }
        }
       
        let param = ["contact_no": selectedIndexArray]
           
           
        
        postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               
                let status = String(response["status"] as? Int ?? 404)
                let message =  String(response["message"] as? String ?? "Error")
                if status != "200"{
                    self.alert(message: message)
                }else{
//                  showSnackBarGray(message: message)
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: PrivateContactsModel = try! JSONDecoder().decode(PrivateContactsModel.self, from: jsonData!)
                    if let friends = blogPosts.users{
//                        self.privateContactsData.removeAll()
//                        self.privateContactsData = friends
                    }
                   
                    self.tbvu.reloadData()
               }
                
                
            }else{
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
//                self.alert(message: error.description)
            }
        }
        
    }
    
}
