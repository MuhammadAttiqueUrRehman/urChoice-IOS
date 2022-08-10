//
//  SearchContactTVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-10.
//

import UIKit

class SearchContactTVC: UITableViewCell {

    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var followImgVu: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var flagImgVu: UIImageView!
    @IBOutlet weak var profileImgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameLbl.textColor = UIColor.white
        profileImgVu?.layer.cornerRadius = (profileImgVu?.frame.size.width ?? 0.0) / 2
        profileImgVu?.clipsToBounds = true
        profileImgVu?.layer.borderWidth = 1.0
        profileImgVu?.layer.borderColor = UIColor.white.cgColor

        // Configure the view for the selected state
    }
    func setData(contact: Users){
        UIHelper.shared.setImage(address: contact.user_img_url ?? "", imgView: profileImgVu)
        UIHelper.shared.setImage(address: contact.user_flag_url ?? "", imgView: flagImgVu)
        let name = (contact.first_name ?? "") +  " " + (contact.last_name ?? "")
        nameLbl.text = name
        if contact.is_friend == 1 && contact.is_follow == 1{
            followBtn.isHidden = true
            followImgVu.isHidden = true
        }else if contact.is_follow == 0{
//            followBtn.setImage(UIImage(named: "follow"), for: .normal)
            followImgVu.image = UIImage(named: "follow")
            
        }else{
            followImgVu.image = UIImage(named: "add_friend")
        }
    }
    
}
