//
//  HistoryCVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-09.
//

import UIKit

class HistoryCVC: UICollectionViewCell {

    @IBOutlet weak var outerVu: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerVu.layer.cornerRadius = 8
    }

}
