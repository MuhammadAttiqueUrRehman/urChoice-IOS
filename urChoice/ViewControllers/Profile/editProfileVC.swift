//
//  editProfileVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit
import AVFoundation
import Foundation
import AVKit
protocol FooTwoViewControllerDelegate {
    func myVCDidFinish()
}
class editProfileVC: BaseViewController {
  var delegate: FooTwoViewControllerDelegate?
    
    @IBOutlet weak var plusImgVu: UIImageView!
    
    @IBOutlet weak var genderImgVu: UIImageView!
    @IBOutlet weak var scrollCntentVuHeightCons: NSLayoutConstraint!
    @IBOutlet weak var flagImgVu: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImgVu: UIImageView!
    
    @IBOutlet weak var tbvu: UITableView!
    
    @IBOutlet weak var scrollVu: UIScrollView!
    
    @IBOutlet weak var scrollContentVu: UIView!
    
    var postsData = [Posts]()
    let userID = defaults.integer(forKey: "userID")
    var observingVlaue = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVu()
       
        tbvu.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        tbvu.isScrollEnabled = false
        tbvu.allowsSelection = false
        tbvu.alwaysBounceVertical = false
        tbvu.estimatedSectionHeaderHeight = 0
        tbvu.estimatedSectionFooterHeight = 0
        tbvu.separatorStyle = .none
       

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getApiData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        if observingVlaue{
        tbvu.removeObserver(self, forKeyPath: "contentSize")
        }
        
    }
    func setupVu(){
        tbvu.register(UINib(nibName: "PostsTVC", bundle: nil), forCellReuseIdentifier: "PostsTVC")
        let genderCheck = defaults.string(forKey: "userGender")
        if genderCheck == "M"{
            genderImgVu.image = UIImage(named: "male2")
        }else{
            genderImgVu.image = UIImage(named: "female2")
           
        }
        let name = defaults.string(forKey: "userName")
        nameLbl.text = name
        let cc = defaults.string(forKey: "userCountrtyCode")
        let flagimage = "flag_" + (cc?.lowercased() ?? "")
        flagImgVu.image = UIImage(named: flagimage)
        timeLbl.text = getTodayString()
        plusImgVu.layer.cornerRadius = 0.5 * plusImgVu.bounds.size.width
        plusImgVu.clipsToBounds = true
        if let bgImage = UserDefaults.standard.imageForKey(key: "imageDefaults"){
        profileImgVu.image = bgImage
        }
    }
    func getTodayString() -> String{

            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm:ss a "
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"

            let currentDateStr = formatter.string(from: Date())
            print(currentDateStr)
            return currentDateStr
    }
   
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func plusBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostVC
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func editProfileBtnTpd(_ sender: Any) {
//        delegate?.myVCDidFinish()
//        self.dismiss(animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
               self.navigationController?.pushViewController(vc!, animated: true)
      
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
              
                let newHeight = 500 + (newsize.height)
//                if postsData.count > 1{
//                    newHeight = 500 + (newsize.height - 300)
//                }
                setupscrollvu(height: newHeight)
            }
        }
       
        
    }
    func setupscrollvu(height: CGFloat){
        
    scrollVu.contentSize = CGSize(width: self.view.frame.width - 1, height: height)
        scrollCntentVuHeightCons.constant = height
        
    }
    func getApiData(){
        let url     = EndPoint.BASE_URL + "post/get-posts-by-user-id/" + String(userID)
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
                    let blogPosts: PostsModel = try! JSONDecoder().decode(PostsModel.self, from: jsonData!)
                   
                    if let posts = blogPosts.posts{
                        self.postsData = posts
                    }
                    self.tbvu.delegate = self
                    self.tbvu.dataSource = self
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
                dismissProgress()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func postData(postID: String, BtnTag: Int){
        let url     = EndPoint.BASE_URL + "post/like-dislike-reaction"

       
        let param = ["post_id": postID]
       
           
           
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
                   
                   
//                    tbvu.reloadData()
                    
                    
                  
                    
                }
                
                
            }else{
                hideLoader()
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
//                self.alert(message: error.description)
            }
        }
        
    }
    func deletePost(postID: String, BtnTag: Int){
        let url     = EndPoint.BASE_URL + "post/delete/" + postID

       
        let param = ["": ""]
       
           
           
        showLoader()
        deleteWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               hideLoader()
                let status = String(response["status"] as? Int ?? 404)
                let message = String(response["message"] as? String ?? "Error")
                if status != "200"{
                    self.alert(message: message)
                }else{
                    hideLoader()
                  showSnackBarGray(message: message)
                    postsData.remove(at: BtnTag)
                   
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


extension editProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTVC", for: indexPath) as! PostsTVC
        let post = postsData[indexPath.row]
        cell.setData(post: post)
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTpd(sender:)), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTpd(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
    }
    @objc func likeBtnTpd(sender: UIButton){
        if observingVlaue{
        tbvu.removeObserver(self, forKeyPath: "contentSize")
            observingVlaue = false
        }
        let postID = String(postsData[sender.tag].id ?? 0)
        postData(postID: postID, BtnTag: sender.tag)
        postsData[sender.tag].isLiked = !(postsData[sender.tag].isLiked ?? false)
        if postsData[sender.tag].isLiked ?? false{
            let total = (postsData[sender.tag].total_likes ?? 0) + 1
            postsData[sender.tag].total_likes = total
        }else{
            let total = (postsData[sender.tag].total_likes ?? 0) - 1
            postsData[sender.tag].total_likes = total
        }
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tbvu.reloadRows(at: [indexPath], with: .none)
        
    }
    @objc func deleteBtnTpd(sender: UIButton){
//        if observingVlaue{
//        tbvu.removeObserver(self, forKeyPath: "contentSize")
//            observingVlaue = false
//        }
        
        let postID = String(postsData[sender.tag].id ?? 0)
        deletePost(postID: postID, BtnTag: sender.tag)
        
    }
}




