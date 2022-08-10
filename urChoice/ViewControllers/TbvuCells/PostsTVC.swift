//
//  PostsTVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-03-07.
//

import UIKit
import AVKit
import AVFoundation
import Foundation

class PostsTVC: UITableViewCell {
    @IBOutlet weak var txtVu: UITextView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var deleteImgVu: UIImageView!
    @IBOutlet weak var txtVuHeightCons: NSLayoutConstraint!
    @IBOutlet weak var videoOuterVuHeightCons: NSLayoutConstraint!
    @IBOutlet weak var likeImgVu: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var videoOuterVu: UIView!
   
    @IBOutlet weak var imgVu: ScaledHeightImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(post: Posts){
        likesLbl.text = String(post.total_likes ?? 0)
        if post.isLiked ?? false{
            likeImgVu.image = UIImage(named: "like-2")
        }else{
            likeImgVu.image = UIImage(named: "unlike")
        }
        if post.files?.count == 0{
            txtVu.text = post.post_text
            videoOuterVuHeightCons.constant = 0
        }else{
            if post.files?[0].type == "image"{
                if post.post_text != ""{
                    txtVu.text = post.post_text
                }else{
                    txtVuHeightCons.constant = 0
                }
                videoOuterVuHeightCons.constant = 250
                imgVu.isHidden = false
                UIHelper.shared.setImageAspectFit(address: post.files?[0].full_url ?? "", imgView: imgVu)
            }else{
                if post.post_text != ""{
                    txtVu.text = post.post_text
                }else{
                    txtVuHeightCons.constant = 0
                }
               
                imgVu.isHidden = true
                videoOuterVuHeightCons.constant = 400
                let fileUrl = URL(string: post.files?[0].full_url ?? "")
                let player = AVPlayer(url: fileUrl!)
                let avPlayerController = AVPlayerViewController()

                avPlayerController.player = player
                avPlayerController.view.frame = videoOuterVu.bounds;

//                self.addChild(avPlayerController)
                self.videoOuterVu.addSubview(avPlayerController.view)
            }
        }
    }
    
}
