//
//  LastMessageCell.swift
//  urChoice
//
//  Created by Mazhar on 2022-07-03.
//

import UIKit

class LastMessageCell: UITableViewCell {

    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var flagImgVu: UIImageView!
    
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImgVu?.layer.cornerRadius = (profileImgVu?.frame.size.width ?? 0.0) / 2
        profileImgVu?.clipsToBounds = true
        profileImgVu?.layer.borderWidth = 1.0
        profileImgVu?.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
