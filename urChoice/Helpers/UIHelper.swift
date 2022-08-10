//
//  UIHelper.swift
//  GiveAndTake
//
//  Created by Mazhar on 2021-06-12.
//

import Foundation
import Nuke
struct UIHelper {
    init() {}
    
    static let shared = UIHelper()
    func setImage(address: String, imgView: UIImageView){
        let userPlaceHolder = ImageLoadingOptions(
            placeholder: UIImage(named: "salon"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(named: "salon"),
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .scaleAspectFill)
            
        )
        
        if let url = URL(string: address){
            Nuke.loadImage(with: url, options: userPlaceHolder, into: imgView)
        }
        else
        {
            Nuke.loadImage(with: URL(string: "URL")!, options: userPlaceHolder, into: imgView)
        }
        
    }
}
