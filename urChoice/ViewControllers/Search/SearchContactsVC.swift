//
//  SearchContactsVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-10.
//

import UIKit

class SearchContactsVC: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var genderBtn: UIButton!
    
    @IBOutlet weak var searchOuterVu: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tbvu: UITableView!
    var contactsData: SearchContactsModel?
    var searchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTF.delegate = self
        setupVu()
        tbvu.delegate = self
        tbvu.dataSource = self
        searchTF.text = searchText
        if genderBtn.isSelected{
        getApiData(gender: "F")
        }else{
            getApiData(gender: "M")
        }

        // Do any additional setup after loading the view.
    }
    func setupVu(){
        
        searchOuterVu.layer.borderWidth = 1
        searchOuterVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        tbvu.register(UINib(nibName: "SearchContactTVC", bundle: nil), forCellReuseIdentifier: "SearchContactTVC")
        tbvu.separatorStyle = .none
        tbvu.backgroundColor = UIColor.black
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        if genderBtn.isSelected{
        getApiData(gender: "F")
        }else{
            getApiData(gender: "M")
        }
        
    }
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func genderBtnTpd(_ sender: UIButton) {
        genderBtn.isSelected.toggle()
        if genderBtn.isSelected{
            genderBtn.setImage(UIImage(named: "female2"), for: .normal)
        }else{
            genderBtn.setImage(UIImage(named: "male2"), for: .normal)
        }
    }
    
    func getApiData(gender: String){
        let url     = EndPoint.BASE_URL + "user/search" + "?name_like=" + searchTF.text! + "&gender=" + gender
        let param   = ["":""]
        
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
                dismissProgress()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: SearchContactsModel = try! JSONDecoder().decode(SearchContactsModel.self, from: jsonData!)
                   
                    self.contactsData = blogPosts
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
                dismissProgress()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func SubmitData(isFollow: Bool, userId: String, tag: Int){
        let url     = EndPoint.BASE_URL + "user/friend-request"

       
        var param = ["interests": ""]
        if isFollow{
            param = ["user_id": userId, "type": "follow"]
        }else{
            param = ["user_id": userId, "type": "send_request"]
        }
           
           
        
        postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               
                let status = String(response["status"] as? Int ?? 404)
                let message = String(response["message"] as? String ?? "Error")
                if status != "200"{
                    self.alert(message: message)
                }else{
                  showSnackBarGray(message: message)
//                    if genderBtn.isSelected{
//                    getApiData(gender: "F")
//                    }else{
//                        getApiData(gender: "M")
//                    }
                    if isFollow{
                        contactsData?.users?[tag].is_follow = 1
                    }else{
                        contactsData?.users?[tag].is_friend = 1
                    }
                    tbvu.reloadData()
                    
                    
                  
                    
                }
                
                
            }else{
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
//                self.alert(message: error.description)
            }
        }
        
    }
    
}


extension SearchContactsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsData?.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchContactTVC", for: indexPath) as! SearchContactTVC
        cell.contentView.backgroundColor = UIColor.black
        cell.setData(contact: (contactsData?.users?[indexPath.row])!)
        cell.followBtn.tag = indexPath.row
        cell.followBtn.addTarget(self, action: #selector(followBtnTpd(sender:)), for: .touchUpInside)
        cell.profileBtn.tag = indexPath.row
        cell.profileBtn.addTarget(self, action: #selector(profileBtnTpd(sender:)), for: .touchUpInside)
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
    }
    @objc func profileBtnTpd(sender: UIButton){
        let buttonTag = sender.tag
        let id = contactsData?.users?[buttonTag].id ?? 0
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "OtherProfileVC") as? OtherProfileVC
        vc?.userID = String(id)
        vc?.userName = contactsData?.users?[buttonTag].user_name ?? ""
        vc?.genderCheck = contactsData?.users?[buttonTag].user_gender ?? ""
        vc?.userFlagURL = contactsData?.users?[buttonTag].user_flag_url ?? ""
        vc?.dob = contactsData?.users?[buttonTag].user_dob ?? ""
        vc?.userImage = contactsData?.users?[buttonTag].user_img_url ?? ""
        
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func followBtnTpd(sender: UIButton){
       
        let buttonTag = sender.tag
        let id = contactsData?.users?[buttonTag].id ?? 0
        if contactsData?.users?[buttonTag].is_follow == 0{
            
            SubmitData(isFollow: true, userId: String(id), tag: buttonTag)
        }else{
            SubmitData(isFollow: false, userId: String(id), tag: buttonTag)
        }
        
    }
}

