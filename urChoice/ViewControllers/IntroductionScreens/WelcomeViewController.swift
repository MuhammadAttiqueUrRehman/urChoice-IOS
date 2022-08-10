//
//  WelcomeViewController.swift
//  uChoice
//
//  Created by iOS Developer on 27/06/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit
var userName = ""

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLbl.text = "Welcome" + " " + userName + "!"
    }
    
    @IBAction func actionOK(_ sender: Any) {
 let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    @IBAction func skipBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
