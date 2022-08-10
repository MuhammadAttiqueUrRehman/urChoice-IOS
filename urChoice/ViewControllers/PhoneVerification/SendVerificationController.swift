//
//  SendVerificationController.swift
//  uChoice
//
//  Created by Waqas Ahmad on 28/12/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit

class SendVerificationController: UIViewController {
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblPhoneCode: UILabel!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.txtPhoneNumber.layer.sublayerTransform  = CATransform3DMakeTranslation(10, 0, 0)
        txtPhoneNumber.layer.borderWidth = 1
        txtPhoneNumber.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        txtPhoneNumber.keyboardType = .asciiCapableNumberPad
        txtPhoneNumber.delegate = self
//       self.addCustomToolBar(textField: txtPhoneNumber)
 
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
   
    //MAR:- Functions
    
    
    func checkNumberValidation() -> Bool {
        if(self.txtPhoneNumber.text!.isEmpty || self.txtPhoneNumber.text!.count < 10){
            return false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:-ACTION METHODS

    
    @IBAction func actionOpenCountryPicker(_ sender: AnyObject) {
        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        picker.delegate = self
        picker.showCallingCodes = true
        self.navigationController?.pushViewController(picker, animated: true)
    }

    @IBAction func actionDismis(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    
}
//MARK:- Country Picker Delegates
extension SendVerificationController: MICountryPickerDelegate {
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
    }
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        picker.navigationController?.setNavigationBarHidden(true, animated: true)
        picker.navigationController?.popViewController(animated: true)
        let bundle = "assets.bundle/"
        let image = bundle + code.lowercased() + ".png"
       countryDialCode = dialCode
       countryCode = code
       country = name
        self.imgFlag.image = UIImage(named: image)
        self.lblPhoneCode.text = dialCode
       
    }
}
//MARK:- TextField Delegates
extension SendVerificationController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtPhoneNumber {
          if textField.text?.count ?? 0 >= 6{
              loginBtn.backgroundColor = UIColor.green
          }
        }
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if(newString.length == 1){
                if(newString == "0"){
                    textField.text = ""
                    return false
                }
                
        }
        
        return true
    }
    
}
extension SendVerificationController {
    func addCustomToolBar(textField:UITextField)
    {
        var buttonDone = UIBarButtonItem()
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //buttonDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action:#selector(BaseViewController.doneClicked(_:)))
        
        
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(SendVerificationController.moveController(_:)), for: .touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //  button.setTitleColor(UIColor(netHex: 0xAE2540), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.contentMode = UIView.ContentMode.right
        button.frame = CGRect(x:0, y:0, width:60, height:40)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        buttonDone = UIBarButtonItem(customView: button)
        
        
        toolbar.setItems(Array.init(arrayLiteral: buttonflexible,buttonDone), animated: true)
        textField.inputAccessoryView = toolbar
        
    }
    @IBAction func moveController(_ sender:AnyObject)
    {
//
        if(self.checkNumberValidation()){
            phoneNumber = self.txtPhoneNumber!.text!
//            Global.shared.user.locationImage = self.country
          locationCode = countryDialCode
           self.checkMobileNumber()
        }else{
           
            showSnackBarRed(message: "Please enter a valid phone number")
            self.view.endEditing(true)
        }
//
    }
    
    
}
//MARK:- CHECK MOBILE NUMBER API
extension SendVerificationController{
    func checkMobileNumber()  {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VerifyNumberController") as? VerifyNumberController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func showValidationController(){
        
    }
    func showLoginController(){
        
    }
}
