//
//  GenderPickerViewController.swift
//  uChoice
//
//  Created by iOS Developer on 26/06/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit

class GenderPickerViewController: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var maleGreenLight: UIImageView!
    @IBOutlet weak var femaleGreenLight: UIImageView!
    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var nameOuterVu: UIView!
    @IBOutlet weak var dobOuterVu: UIView!
    @IBOutlet weak var profileImgVu: UIImageView!
   
    @IBOutlet weak var lblDateofBirth: UILabel!
   
    @IBOutlet weak var txtName : UITextField!
    var imagePicker = UIImagePickerController()
    var signUpData: SignUpModel?
    
    var gender = kBlankString
    var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        dobOuterVu.layer.cornerRadius = 8
        dobOuterVu.layer.borderWidth = 1
        dobOuterVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        
        nameOuterVu.layer.cornerRadius = 8
        nameOuterVu.layer.borderWidth = 1
        nameOuterVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        txtName.tintColor = UIColor().colorForHax("#D09715")
        
       
        
        profileImgVu?.layer.cornerRadius = (profileImgVu?.frame.size.width ?? 0.0) / 2
        profileImgVu?.clipsToBounds = true
        profileImgVu?.layer.borderWidth = 1.0
        profileImgVu?.layer.borderColor = UIColor.white.cgColor
        maleGreenLight.isHidden = true
        femaleGreenLight.isHidden = true
        

    }
    
   

    @IBAction func profileImgVuBtnTpd(_ sender: Any) {
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
            profileImgVu.image = image
            selectedImage = image
            if lblDateofBirth.text != "Date of birth" && gender != kBlankString && txtName.text != kBlankString && profileImgVu.image != nil{
                signUpBtn.layer.backgroundColor = UIColor().colorForHax("#39CF5D").cgColor
            }
          self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func actionDoneDatePicker(_ sender: Any) {
//        UIView.animate(withDuration: 0.6, animations: {
//            self.datePickerView.alpha = 0
//        }) { (_) in
//            self.datePickerView.isHidden = true
//        }
//
//        let date = datePicker.date.convert(into: "dd MMM yyyy")
//        lblDateofBirth.text = date
        
       
    }
    
    @IBAction func actionSelectDOB(_ sender: Any) {
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
            
            self?.lblDateofBirth.text = finalDate
            if self?.lblDateofBirth.text != "Date of birth" && self?.gender != kBlankString && self?.txtName.text != kBlankString && self?.profileImgVu.image != nil{
                self?.signUpBtn.layer.backgroundColor = UIColor().colorForHax("#39CF5D").cgColor
            }
      
      
                     })
    }
    
    @IBAction func actionMale(_ sender: Any) {
        gender = "M"
       
        maleGreenLight.isHidden = false
        femaleGreenLight.isHidden = true
        if lblDateofBirth.text != "Date of birth" &&  self.txtName.text != kBlankString && profileImgVu.image != nil{
            signUpBtn.layer.backgroundColor = UIColor().colorForHax("#39CF5D").cgColor
        }
    }
    
    @IBAction func actionFemale(_ sender: Any) {
        gender = "F"
       
        maleGreenLight.isHidden = true
        femaleGreenLight.isHidden = false
        if lblDateofBirth.text != "Date of birth" &&  self.txtName.text != kBlankString && profileImgVu.image != nil{
            signUpBtn.layer.backgroundColor = UIColor().colorForHax("#39CF5D").cgColor
        }
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        if lblDateofBirth.text == "Date of birth" {
            showSnackBarRed(message: "Select date of birth")
        }else if gender == kBlankString {
            showSnackBarRed(message: "Select your gender")
        }
        else if self.txtName.text == kBlankString {
            showSnackBarRed(message: "Enter your Full Name")
        }
        else {
          
submitData()
//            self.createUserAccount()
//            moveToWelcome()

//        }

        
    }
    }
    func submitData(){
        showLoader()
        let url = EndPoint.BASE_URL + "auth/signup"
        let deviceId = (UIDevice.current.identifierForVendor?.uuidString)!
        let param = ["phone": (locationCode + phoneNumber),"device_token": deviceId,"first_name":txtName.text!,"last_name":txtName.text!,"gender":gender,"dob":lblDateofBirth.text!, "country_code": countryCode] as [String : Any]
                let data = profileImgVu.image?.jpegData(compressionQuality: 0.5)
        webCallWithImageWithName(url: url, parameters: param, webCallName: "edit profile", imgData: data!, imageName: "image", sender: self) { (response, error) in
            let status = String(response["status"] as? Int ?? 0)
            let message = String(response["message"] as? String ?? "")
                    if !error{
                        self.hideLoader()
//                        let device = UIDevice.current.identifierForVendor?.uuidString
                        let jsonString = jsonToString(jsonTOConvert: response)
                         let jsonData = jsonString.data(using: .utf8)
                        let blogPosts: SignUpModel = try! JSONDecoder().decode(SignUpModel.self, from: jsonData!)
                        self.signUpData = blogPosts
                        let data = self.signUpData.map { try? JSONEncoder().encode($0) }
                        UserDefaults.standard.set(data, forKey: "userData")
                        let token = (self.signUpData?.user?.auth_token)! + "-" + (self.signUpData?.user?.device_token)!
                        DEFAULTS.setValue(token, forKeyPath: "authToken")
                        DEFAULTS.setValue(blogPosts.user?.id, forKeyPath: "userID")
                        DEFAULTS.setValue(self.txtName.text!, forKeyPath: "userName")
                        DEFAULTS.setValue(self.lblDateofBirth.text, forKeyPath: "userDOB")
                        DEFAULTS.setValue(self.gender, forKeyPath: "userGender")
                        DEFAULTS.setValue(blogPosts.user?.user_country_code, forKeyPath: "userCountrtyCode")
                       showSnackBarGreen(message: message)
                        userName = self.txtName.text!
                        self.selectedImage = self.profileImgVu.image!

                        UserDefaults.standard.setImage(image: self.selectedImage, forKey: "imageDefaults")
                        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                       
                    }else{
                        self.hideLoader()
                        showSnackBarRed(message: message)
                    }
                }

    }
//    
}

extension GenderPickerViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if lblDateofBirth.text != "Date of birth" && gender != kBlankString && txtName.text != kBlankString && profileImgVu.image != nil{
            signUpBtn.layer.backgroundColor = UIColor().colorForHax("#39CF5D").cgColor
        }
    }
    
}

extension String
{
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

