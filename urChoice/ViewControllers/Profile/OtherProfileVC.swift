//
//  OtherProfileVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-03-11.
//

import UIKit

class OtherProfileVC: BaseViewController {
    
    
   
    
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
    
    
    var userID = ""
    var postsData = [Posts]()
    var userName = ""
    var userImage = ""
    var genderCheck = ""
    var userFlagURL = ""
    var dob = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVu()
       
        tbvu.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        tbvu.isScrollEnabled = false
        tbvu.allowsSelection = false
      

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getApiData()
    }
    func setupVu(){
        tbvu.register(UINib(nibName: "PostsTVC", bundle: nil), forCellReuseIdentifier: "PostsTVC")
       
        if genderCheck == "M"{
            genderImgVu.image = UIImage(named: "male2")
        }else{
            genderImgVu.image = UIImage(named: "female2")
           
        }
       
        nameLbl.text = userName
       
        timeLbl.text = getTodayString()
        UIHelper.shared.setImageAspectFit(address: userImage, imgView: profileImgVu)
        UIHelper.shared.setImageAspectFit(address: userFlagURL, imgView: flagImgVu)
       
        
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
    
   
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
              
                let newHeight = 500 + newsize.height
                setupscrollvu(height: newHeight)
            }
        }
       
        
    }
    func setupscrollvu(height: CGFloat){
        
    scrollVu.contentSize = CGSize(width: self.view.frame.width - 1, height: height)
        scrollCntentVuHeightCons.constant = height
        
    }
    
    
    
    
    
    
    
    func getApiData(){
        let url     = EndPoint.BASE_URL + "post/get-posts-by-user-id/" + userID
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
    func likePost(postID: String){
        let url     = EndPoint.BASE_URL + "post/like-dislike"

       
        var param = ["post_id": postID]
        
           
           
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


extension OtherProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTVC", for: indexPath) as! PostsTVC
        let post = postsData[indexPath.row]
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTpd(sender:)), for: .touchUpInside)
        cell.deleteBtn.isHidden = true
        cell.deleteImgVu.isHidden = true
        cell.setData(post: post)
        
        return cell
    }
    @objc func likeBtnTpd(sender: UIButton){
//        let post = postsData[sender.tag]
//        likePost(postID: String(post.id ?? 0))
    }
}


