//
//  RegionalTVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit

class RegionalTVC: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var flagImGvU: UIImageView!
    @IBOutlet weak var selectionImgvu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
