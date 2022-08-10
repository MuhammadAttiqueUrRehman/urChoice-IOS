//
//  LanguageTableViewCell.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-12.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkImgVu: UIImageView!
    @IBOutlet weak var lightImgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//        checkImgVu.image = UIImage(named: "icon_unchecked")
    }
    func setData(language: Languages){
        if language.isSelected!{
            lightImgVu.isHidden = false
            checkImgVu.image = UIImage(named: "icon_checked")
        }else{
            lightImgVu.isHidden = true
            checkImgVu.image = UIImage(named: "icon_unchecked")
        }
    }

}
