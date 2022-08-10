//
//  BlockFriendsTVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-09.
//

import UIKit

class BlockFriendsTVC: UITableViewCell {
    @IBOutlet weak var imgVu: UIImageView!
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
