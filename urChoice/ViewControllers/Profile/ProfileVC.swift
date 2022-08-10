//
//  ProfileVC.swift
//  urChoice
//
//  Created by Mazhar on 2021-12-07.
//

import UIKit

class ProfileVC: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImagebtn: UIButton!
    @IBOutlet weak var femaleLighjt: UIImageView!
    @IBOutlet weak var maleLight: UIImageView!
    @IBOutlet weak var selectLanguageLbl: UILabel!
    @IBOutlet weak var selectInterstLbl: UILabel!
    @IBOutlet weak var interestBtn: UIButton!
    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var languageCV: UICollectionView!
    @IBOutlet weak var interestsCV: UICollectionView!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var profileImgVu: UIImageView!
    
    var interestList = [InterestViewModel]()
    var selectedInterests = [String]()
    var gender = ""
    var imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNib()
        setupVu()
       
        setCollectionLayout()
        
        
        
    }
    func setupVu(){
        interestList.removeAll()
        selectInterstLbl.isHidden = true
        selectedImage = profileImgVu.image!
        let genderCheck = defaults.string(forKey: "userGender")
        if genderCheck == "M"{
            maleBtn.isSelected = true
            femaleBtn.isSelected = false
            maleLight.isHidden = false
            femaleLighjt.isHidden = true
            gender = "M"
        }else{
            maleBtn.isSelected = false
            femaleBtn.isSelected = true
            maleLight.isHidden = true
            femaleLighjt.isHidden = false
            gender = "F"
        }
        let name = defaults.string(forKey: "userName")
        nameLbl.text = name
        let dob = defaults.string(forKey: "userDOB")
        dateTF.text = dob
        let address = defaults.string(forKey: "userAddress")
        addressTV.text = address
        if let bgImage = UserDefaults.standard.imageForKey(key: "imageDefaults"){
        profileImgVu.image = bgImage
        }
        let itemsData = loadIntersts()
         if itemsData.count != 0 && itemsData != nil{
            interestList = itemsData
         }
        loadSelectedinterests()
    }
    
    func loadIntersts() -> [InterestViewModel] {
        guard let encodedData = UserDefaults.standard.array(forKey: "userInterests") as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(InterestViewModel.self, from: $0) }
    }
    fileprivate func loadSelectedinterests() {
        selectedInterests.removeAll()
        for interest in interestList {
            if interest.isSelected{
                let name = interest.name
                selectedInterests.append(name)
            }
        }
       
    }
    func setupNib(){
        let nib = UINib(nibName: "GeneralCVC", bundle: nil)
        interestsCV.register(nib, forCellWithReuseIdentifier:
                                "GeneralCVC")
  }
    func setCollectionLayout() {
       let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:5,bottom:0,right:10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        interestsCV.isPagingEnabled = true
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:(interestsCV.frame.width - 30)/2 , height: 200)
       
        interestsCV.collectionViewLayout = layout
       
        if selectedInterests.count != 0{
        interestsCV.delegate = self
        interestsCV.dataSource = self
        }else{
           selectInterstLbl.isHidden = false
         }
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func dateBtnTpd(_ sender: Any) {
        RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                         // TODO: Your implementation for date
      //            selectedDate.dates
      //                   self?.outputLabel.text = selectedDate.dateString("dd/mm/yyyy")
      
                  print(selectedDate)
      
      
                  var finalDate = ""
                  let components = selectedDate.get(.day, .month, .year)
                  if let day = components.day, let month = components.month, let year = components.year {
                      print("day: \(day), month: \(month), year: \(year)")
                      var dayAppend = ""
                      var monthAppend = ""
                      if day < 10{
                       dayAppend = "0" + String(day)
                      }else{
                        dayAppend = String(day)
                      }
                      if month < 10{
                          monthAppend = "0" + String(month)
                        let monthName = DateFormatter().monthSymbols[month - 1]
                        print(monthName)
                        monthAppend = monthName
                      }else{
                        monthAppend = String(month)
                        let monthName = DateFormatter().monthSymbols[month - 1]
                        print(monthName)
                        monthAppend = monthName
                      }
                      finalDate = dayAppend + " " + monthAppend + " " + String(year)
                  }
                  print(finalDate)
            
            self?.dateTF.text = finalDate
           
      
      
                     })
    }
    
    @IBAction func maleBtnTpd(_ sender: UIButton) {
       switch sender.tag {
        case 0:
            if maleBtn.isSelected{
                maleBtn.isSelected = true
                maleLight.isHidden = false
                gender = "M"
            }else{
                maleBtn.isSelected = true
                maleLight.isHidden = false
                femaleBtn.isSelected = false
                femaleLighjt.isHidden = true
                gender = "M"
            }
        case 1:
            if femaleBtn.isSelected{
                femaleBtn.isSelected = true
                femaleLighjt.isHidden = false
                gender = "F"
            }else{
                femaleBtn.isSelected = true
                femaleLighjt.isHidden = false
                maleBtn.isSelected = false
                maleLight.isHidden = true
                gender = "F"
            }
        default:
            print("Anything")
        }
        
        
        
    }
    
    @IBAction func profileImgBtnTpd(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
           
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ [self] (UIAlertAction)in
               print("User click Approve button")
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
           }))
           
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ [self] (UIAlertAction)in
               print("User click Edit button")
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                      print("Button capture")
              imagePicker.delegate = self
                      imagePicker.sourceType = .savedPhotosAlbum
                      imagePicker.allowsEditing = false
                      
                      present(imagePicker, animated: true, completion: nil)
                  }
           }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))

          
           //uncomment for iPad Support
           //alert.popoverPresentationController?.sourceView = self.view

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.profileImgVu.image = image
                self.selectedImage = image
            })
           
           
          
           
          self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func languagesBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as? LanguagesViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func saveBtnTpd(_ sender: Any) {
        submitData()
    }
    @IBAction func interestsBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController
        vc?.isFromProfile = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func submitData(){
        showLoader()
        let url = EndPoint.BASE_URL + "user/update-profile"
       
        let param = ["first_name": nameLbl.text!,"dob": dateTF.text!,"gender":gender, "address": addressTV.text ?? ""] as [String : Any]
                let data = profileImgVu.image?.jpegData(compressionQuality: 0.5)
        webCallWithImageWithNameHeader(url: url, parameters: param, webCallName: "edit profile", imgData: data!, imageName: "profile_pic", sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        self.hideLoader()
//                        let device = UIDevice.current.identifierForVendor?.uuidString
                        showSnackBarGray(message: message)
                        DEFAULTS.setValue(self.nameLbl.text!, forKeyPath: "userName")
                        DEFAULTS.setValue(self.dateTF.text!, forKeyPath: "userDOB")
                        DEFAULTS.setValue(self.gender, forKeyPath: "userGender")
                        DEFAULTS.setValue(self.addressTV.text ?? "", forKeyPath: "userAddress")
                        self.selectedImage = self.profileImgVu.image!
                      UserDefaults.standard.setImage(image: self.selectedImage, forKey: "imageDefaults")
                       
                       
                    }else{
                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
}



extension ProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestsCV{
            return selectedInterests.count
        }else{
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCVC", for: indexPath) as! GeneralCVC
        if collectionView == interestsCV{
            cell.titleLbl.text = "#" + selectedInterests[indexPath.item]
        }
           return cell
        
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        if collectionView == interestsCV{
        let label = UILabel(frame: CGRect.zero)
                label.text = selectedInterests[indexPath.item]
                label.sizeToFit()
                return CGSize(width: (label.frame.width + 55), height: 32)
           
       
        }else{
            return CGSize(width:60 , height: 0)
        }
        
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
            
   
    
}
