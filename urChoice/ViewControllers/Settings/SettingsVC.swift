//
//  SettingsVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuBtnTpd(_ sender: UIButton) {
        switch sender.tag{
        case 1:
            
                let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HistoryVC") as? HistoryVC
                self.navigationController?.pushViewController(vc!, animated: true)
        case 5:
            let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TermsConditionsViewController") as? TermsConditionsViewController
            vc?.comefromSettings = true
            self.navigationController?.pushViewController(vc!, animated: true)
        case 100:
            let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GemsVC") as? GemsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        default:
            print("")
        }
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
