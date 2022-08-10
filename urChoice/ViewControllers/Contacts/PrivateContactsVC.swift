//
//  PrivateContactsVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-03-10.
//

import UIKit
import ContactsUI
import PhoneNumberKit

class PrivateContactsVC: UIViewController {

    @IBOutlet weak var tbvu: UITableView!
    var phoneContacts = [PhoneContact]()
    var filter: ContactsFilter = .none
    var phoneNumber = [String]()
    var phoneNumbersWithCountryCode = [String]()
    let phoneNumberKit = PhoneNumberKit()
    var privateContactsData = [PrivateUsers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbvu.register(UINib(nibName: "PrivateContactsTVC", bundle: nil), forCellReuseIdentifier: "PrivateContactsTVC")
        tbvu.separatorStyle = .none
        tbvu.delegate = self
        tbvu.dataSource = self
        tbvu.backgroundColor = UIColor.black
        tbvu.allowsSelection = false
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
    func setupVu(){
        self.loadContacts(filter: filter) // Calling loadContacts methods

              
    }
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
  
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func SubmitData(){
        let url     = EndPoint.BASE_URL + "user/get-user-from-contact-list"
        var selectedIndexArray = [String]()
        for index in phoneNumbersWithCountryCode{
            if selectedIndexArray.count == 0{
                let replaced = index.replacingOccurrences(of: " ", with: "")
                selectedIndexArray.append(replaced)
            }else{
//                selectedIndexArray.append(",")
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
                        self.privateContactsData = friends
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



extension PrivateContactsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateContactsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivateContactsTVC", for: indexPath) as! PrivateContactsTVC
        cell.contentView.backgroundColor = UIColor.black
        cell.nameLbl.text = privateContactsData[indexPath.row].user_name
        cell.phoneLbl.text = privateContactsData[indexPath.row].phone
        UIHelper.shared.setImage(address: privateContactsData[indexPath.row].user_img_url ?? "", imgView: cell.imgVu)
        cell.messageBtn.tag = indexPath.row
        cell.messageBtn.addTarget(self, action: #selector(messageBtnTpd(sender:)), for: .touchUpInside)
      
        return cell
    }
    @objc func messageBtnTpd(sender: UIButton){
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
            vc?.receiverID = String(privateContactsData[sender.tag].id ?? 0)
        vc?.contactType = "private"
        vc?.receiverImgUrl = privateContactsData[sender.tag].user_img_url ?? ""
            vc?.receiverName = privateContactsData[sender.tag].user_name ?? ""
       self.navigationController?.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
//               let vc = storyboard.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
//        vc?.receiverID = String(privateContactsData[indexPath.row].id ?? 0)
//        vc?.contactType = "private"
//        vc?.receiverImgUrl = privateContactsData[indexPath.row].user_img_url ?? ""
//       self.navigationController?.pushViewController(vc!, animated: true)
        
        
    
       
       
    }
    @objc func followBtnTpd(sender: UIButton){
       
       
    }
}


