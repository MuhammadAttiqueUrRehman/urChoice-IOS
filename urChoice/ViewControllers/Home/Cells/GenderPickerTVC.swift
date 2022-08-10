//
//  GenderPickerTVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit

class GenderPickerTVC: UITableViewCell {
    @IBOutlet weak var selectionImGvU: UIImageView!
    
    @IBOutlet weak var imgVuLeadingCons: NSLayoutConstraint!
    @IBOutlet weak var imgVuWidthCons: NSLayoutConstraint!
    @IBOutlet weak var bottomVu: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
