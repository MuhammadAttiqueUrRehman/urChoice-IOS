//
//  ChooseLangVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-13.
//

import UIKit

class ChooseLangVC: BaseViewController {

    @IBOutlet weak var tbvuHeightCons: NSLayoutConstraint!
    @IBOutlet weak var tbvu: UITableView!
    var languages = ["Dutch","German","English"]
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNib()

        // Do any additional setup after loading the view.
    }
    
    func setupNib(){
tbvu.register(UINib(nibName: "GenderPickerTVC", bundle: nil), forCellReuseIdentifier: "GenderPickerTVC")
        tbvu.backgroundColor = UIColor.black

        }
    @IBAction func tapBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
        
}





extension ChooseLangVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenderPickerTVC", for: indexPath) as! GenderPickerTVC
        if selectedIndex != nil && indexPath.row == selectedIndex{
            cell.selectionImGvU.isHidden = false
           
        }else{
            cell.selectionImGvU.isHidden = true
           
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GenderPickerTVC
        cell.selectionImGvU.isHidden = false
        selectedIndex = indexPath.row
       
        tbvu.reloadData()
       
       
    }
    @objc func followBtnTpd(sender: UIButton){
       
        let buttonTag = sender.tag
      
        
    }
}


