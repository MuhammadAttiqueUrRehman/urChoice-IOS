//
//  LanguagesViewController.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-12.
//

import UIKit

class LanguagesViewController: BaseViewController {

    @IBOutlet weak var outerVu: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var tbvu: UITableView!
    var languagesData : LanguagesModel?
    var selectedIndex = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        outerVu.layer.cornerRadius = 15
        tbvu.layer.cornerRadius = 15
        tbvu.delegate = self
        tbvu.dataSource = self
        languagesData?.languages = loadLanguages()
        let langs = loadLanguages()
        if langs.count == 0{
            getApiData()
        }else{
            languagesData?.languages = langs
            tbvu.reloadData()
        }
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func loadLanguages() -> [Languages] {
        print("hhh")
        guard let encodedData = UserDefaults.standard.array(forKey: "userLanguagesList") as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(Languages.self, from: $0) }
    }
    @IBAction func saveBtnTpd(_ sender: Any) {
        selectedIndex = []
        if let languages = languagesData?.languages{
            for lang in languages{
                if lang.isSelected!{
                    let id = String(lang.id!)
                    selectedIndex.append(id)
                }
            }
        }
        let languages = self.languagesData?.languages!
        let data = languages.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data!, forKey: "userLanguagesList")
       SubmitData()
      
    }
    func getApiData(){
        let url     = EndPoint.BASE_URL + "get-languages"
        let param   = ["":""]
        
        getWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
                dismissProgress()
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                   print("success")
                    let jsonString = jsonToString(jsonTOConvert: response)
                     let jsonData = jsonString.data(using: .utf8)
                    let blogPosts: LanguagesModel = try! JSONDecoder().decode(LanguagesModel.self, from: jsonData!)
                    self.languagesData = blogPosts
                    self.tbvu.reloadData()
                   
                }
                
                
            }else{
                dismissProgress()
                showSnackBarGray(message: "Server Error")
            }
        }
        
    }
    func SubmitData(){
        let url     = EndPoint.BASE_URL + "user/update-profile"
      var selectedIndexArray = [String]()
        for index in selectedIndex{
            if selectedIndexArray.count == 0{
                selectedIndexArray.append(index)
            }else{
                selectedIndexArray.append(",")
                selectedIndexArray.append(index)
            }
        }
       
        let param = ["languages": selectedIndex]
           
           
        
        postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               
                let status = String(response["status"] as? Int ?? 404)
                let message = "\(String(describing: response["message"]))"
                if status != "200"{
                    self.alert(message: message)
                }else{
                  showSnackBarGray(message: message)
                    
                  
                    
                }
                
                
            }else{
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
//                self.alert(message: error.description)
            }
        }
        
    }
    
}


extension LanguagesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesData?.languages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
        cell.setData(language: (languagesData?.languages?[indexPath.row])!)
        cell.titleLbl.text = languagesData?.languages?[indexPath.row].name
        cell.contentView.backgroundColor = UIColor.black
       
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tbvu.deselectRow(at: indexPath, animated: false)
        var selected =  languagesData?.languages?[indexPath.row].isSelected
        selected = !(selected ?? false)
        languagesData?.languages?[indexPath.row].isSelected = selected
        self.tbvu.reloadData()
       
       
    }
}

