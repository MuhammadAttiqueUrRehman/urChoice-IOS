//
//  showAddPostVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-03-07.
//

import UIKit
import AVFoundation
import AVKit

class showAddPostVC: BaseViewController {
    var text = ""
    var image = UIImage()
    var videoURL : URL?
    var isImageType = false
    @IBOutlet weak var txtVu: UITextView!
    @IBOutlet weak var imgVu: UIImageView!
    
    @IBOutlet weak var outerVu: UIView!
    let userID = defaults.integer(forKey: "userID")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVu.layer.cornerRadius = 20
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setupVu()
    }
    func setupVu(){
        if text != ""{
            txtVu.text = text
        }
        if isImageType{
            imgVu.image = image
        }else{
            imgVu.isHidden = true
//           let player = AVPlayer(url: videoURL!)
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.outerVu.bounds
//           outerVu.layer.addSublayer(playerLayer)
//
//
//            player.play()
            
            let player = AVPlayer(url: videoURL!)
            let avPlayerController = AVPlayerViewController()

            avPlayerController.player = player
            avPlayerController.view.frame = self.outerVu.bounds;

            self.addChild(avPlayerController)
            self.outerVu.addSubview(avPlayerController.view)
            
            
          
        }
    }
    
    @IBAction func publishBtnTpd(_ sender: Any) {
        if isImageType{
            submitDataImage()
        }else{
            submitDataVideo()
        }
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func submitDataImage(){
        showLoader()
        let url = EndPoint.BASE_URL + "post/add"
        if txtVu.text == "Write Something"{
            
        }
        var param = ["text": txtVu.text!] as [String : Any]
        if txtVu.text == "Write Something"{
           param = ["text": ""] as [String : Any]
        }
                let data = imgVu.image?.jpegData(compressionQuality: 0.5)
        webCallWithImageWithNameHeader(url: url, parameters: param, webCallName: "edit profile", imgData: data!, imageName: "image", sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        self.hideLoader()
print("Yes we did it")
                        showSnackBarGreen(message: message)
                        self.navigationController?.popToRootViewController(animated: true)
                       
                       
                    }else{
                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
    func submitDataVideo(){
        showLoader()
        let url = EndPoint.BASE_URL + "post/add"
       
        var param = ["text": txtVu.text!] as [String : Any]
        if txtVu.text == "Write Something"{
           param = ["text": ""] as [String : Any]
        }
               
        webCallWithVideoHeader(url: url, parameters: param, webCallName: "edit profile",videoUrl: videoURL,sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        self.hideLoader()
print("Yes we did it")
                        showSnackBarGreen(message: message)
                        self.navigationController?.popToRootViewController(animated: true)
                       
                    }else{
                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
}
