//
//  PrivateContactsTVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-03-10.
//

import UIKit

class PrivateContactsTVC: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var imgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgVu?.layer.cornerRadius = (imgVu?.frame.size.width ?? 0.0) / 2
        imgVu?.clipsToBounds = true
        imgVu?.layer.borderWidth = 1.0
        imgVu?.layer.borderColor = UIColor.white.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
