//
//  RegionalVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit

class RegionalVC: UIViewController {
    
   var selectedCOuntryIndex = UserDefaults.standard.integer(forKey: "selectedCountryRegion")
    let scrollConternt = UserDefaults.standard.float(forKey: "scrollContent")

    @IBOutlet weak var tbvu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNib()
        tbvu.dataSource = self
        tbvu.delegate = self
       let timezones = TimeZone.knownTimeZoneIdentifiers
        print(timezones)
        tbvu.setContentOffset(CGPoint(x: 0, y: Int(scrollConternt)), animated: false)
        
//        let indexPath = IndexPath(row: selectedCOuntryIndex, section: 0)
//        tbvu.scrollToRow(at: indexPath, at: .top, animated: true)

        // Do any additional setup after loading the view.
    }
    func setupNib(){
tbvu.register(UINib(nibName: "RegionalTVC", bundle: nil), forCellReuseIdentifier: "RegionalTVC")

        }
    
    
    @IBAction func okBtnTpd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

}






extension RegionalVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionalTVC", for: indexPath) as! RegionalTVC
        cell.contentView.backgroundColor = UIColor.black
        cell.countryLbl.text = countryNameList[indexPath.row]
        let imgAddress = "flag_" + countryCodeList[indexPath.row].lowercased()
//            UIHelper.shared.setImage(address: imgAddress, imgView: cell.flagImGvU)
        if indexPath.row == 0{
            cell.flagImGvU.image = UIImage(named: "flag_default")
        }else{
        cell.flagImGvU.image = UIImage(named: imgAddress)
        }
        cell.selectionImgvu.isHidden = true
        if selectedCOuntryIndex != nil && indexPath.row == selectedCOuntryIndex {
            cell.selectionImgvu.isHidden = false
        }
       
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let verticalContentOffset  = tbvu.contentOffset.y 
        UserDefaults.standard.set(verticalContentOffset, forKey: "scrollContent")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedCountryRegion")  //Integer
       
        let cell = tableView.cellForRow(at: indexPath) as! RegionalTVC
        cell.selectionImgvu.isHidden = false
        selectedCOuntryIndex = indexPath.row
        tbvu.reloadData()
        
    }
   
}
    




