//
//  GenderPickerPopUp.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit

class GenderPickerPopUp: UIViewController {
    
    @IBOutlet weak var tbvu: UITableView!
    
    var selectedImgesArray = ["group","both_selected","female_selected","male_selected"]
    var unselectedImagesArray = ["group_unselected","both_unselected","female_unselected","male_unselected"]
    var selectedGenderIndex = UserDefaults.standard.integer(forKey: "selectedGenderPrefrence")
    var titleArray = ["Group Call","Both","Female","Male"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNib()
        tbvu.delegate = self
        tbvu.dataSource = self

        // Do any additional setup after loading the view.
    }
    func setupNib(){
tbvu.register(UINib(nibName: "GenderPickerTVC", bundle: nil), forCellReuseIdentifier: "GenderPickerTVC")

        }
    
    @IBAction func okBtnTpd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

}








extension GenderPickerPopUp: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenderPickerTVC", for: indexPath) as! GenderPickerTVC
        
        cell.titleLbl.text = titleArray[indexPath.row]
        if indexPath.row == 0 || indexPath.row == 3{
            cell.bottomVu.isHidden = false
        }else{
            cell.bottomVu.isHidden = true
        }
        if selectedGenderIndex != nil && indexPath.row == selectedGenderIndex{
            cell.selectionImGvU.isHidden = false
            cell.imgVu.image = UIImage(named: selectedImgesArray[selectedGenderIndex])
        }else{
            cell.selectionImGvU.isHidden = true
            cell.imgVu.image = UIImage(named: unselectedImagesArray[indexPath.row])
        }
      
        
       
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let verticalContentOffset  = tbvu.contentOffset.y
        UserDefaults.standard.set(verticalContentOffset, forKey: "scrollContent")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedGenderPrefrence")  //Integer
       
        let cell = tableView.cellForRow(at: indexPath) as! GenderPickerTVC
        cell.selectionImGvU.isHidden = false
        selectedGenderIndex = indexPath.row
       
        tbvu.reloadData()
        
    }
   
}
    





