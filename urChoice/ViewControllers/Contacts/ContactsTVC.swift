//
//  ContactsTVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-13.
//

import UIKit

class ContactsTVC: UITableViewCell {

    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var buttonsOuterVu: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageOuterVu: UIView!
    @IBOutlet weak var profileImgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        profileImgVu?.layer.cornerRadius = (profileImgVu?.frame.size.width ?? 0.0) / 2
        profileImgVu?.clipsToBounds = true
        profileImgVu?.layer.borderWidth = 1.0
        profileImgVu?.layer.borderColor = UIColor.white.cgColor
    }
    
    
}
enum contactModeltype{
    case privateFrieds
    case urChoiceContacts
    case received
    case requests
}
