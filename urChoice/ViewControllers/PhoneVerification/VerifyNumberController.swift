//
//  VerifyNumberController.swift
//  uChoice
//
//  Created by Waqas Ahmad on 28/12/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit
import Firebase

class VerifyNumberController: BaseViewController {
    @IBOutlet weak var txtCode : UITextField!
    @IBOutlet weak var btnVerify : UIButton!
    @IBOutlet weak var btnResend : UIButton!
    @IBOutlet weak var lblResendTimer : UILabel!
    @IBOutlet weak var lblNumber : UILabel!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtSixth: UITextField!
    var otpText = ""
    var timeCount = 60
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTimer()
        self.lblNumber.text = locationCode + phoneNumber
        self.setTimer()
//        self.sendVerificationCode()
        txtCode.delegate = self
        // Do any additional setup after loading the view.
        
        if #available(iOS 12.0, *) {
                 txtFirst.textContentType = .oneTimeCode
                 txtSecond.textContentType = .oneTimeCode
                 txtThird.textContentType = .oneTimeCode
                 txtFourth.textContentType = .oneTimeCode
                 txtFifth.textContentType = .oneTimeCode
             }

             txtFirst.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
             txtSecond.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
             txtThird.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
             txtFourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
             txtFifth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtSixth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
             txtFirst.becomeFirstResponder() //by doing this it will open the keyboard on first text field automatically
    }
    //When changed value in textField
       @objc func textFieldDidChange(textField: UITextField){
           let text = textField.text
           if  text?.count == 1 {
               switch textField{

               case txtFirst:
                   txtSecond.becomeFirstResponder()
               case txtSecond:
                   txtThird.becomeFirstResponder()
               case txtThird:
                   txtFourth.becomeFirstResponder()
               case txtFourth:
                   txtFifth.becomeFirstResponder()
               case txtFifth:
                txtSixth.becomeFirstResponder()
               case txtSixth:
                txtSixth.resignFirstResponder()
                   self.dismissKeyboard()
               default:
                   break
               }
           }
           if  text?.count == 0 {
               switch textField{
               case txtFirst:
                   txtFirst.becomeFirstResponder()
               case txtSecond:
                   txtFirst.becomeFirstResponder()
               case txtThird:
                   txtSecond.becomeFirstResponder()
               case txtFourth:
                   txtThird.becomeFirstResponder()
               case txtFifth:
                   txtFourth.becomeFirstResponder()
               case txtSixth:
                txtFifth.becomeFirstResponder()
               default:
                   break
               }
           }
           else{

           }
       }
    func dismissKeyboard(){

            self.otpText = "\(self.txtFirst.text ?? "")\(self.txtSecond.text ?? "")\(self.txtThird.text ?? "")\(self.txtFourth.text ?? "")\(self.txtFifth.text ?? "")\(self.txtSixth.text ?? "")"

            print(self.otpText)
            self.view.endEditing(true)

        }
    func setTimer()  {
        self.timeCount = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.handleCountDown), userInfo: nil, repeats: true)
    }
    @objc func handleCountDown() {
        timeCount = timeCount-1
        if(timeCount == 0){
            self.btnResend.isHidden = false;
            self.timer?.invalidate()
        }else if(timeCount < 10){
            self.lblResendTimer.text = "Resend in 00:0\(timeCount) sec"
        }else{
            self.lblResendTimer.text = "Resend in 00:\(timeCount) sec"
        }
    }
    
    @IBAction func actionDismis(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionVerify(_ sender : UIButton){
       showLoader()
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "",
            verificationCode: otpText)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            self.hideLoader()
          if let error = error {
            let authError = error as NSError
            self.showAlert(message: error.localizedDescription)
          }else{
            print("succeed")
            self.moveToGender()
          }
            
        }

    }
    func moveToGender() {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GenderPickerViewController") as? GenderPickerViewController
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    func moveToHomeScreen() {
//        let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.MainContainerViewController) as! MainContainerViewController
//        self.navigationController?.setViewControllers([controller], animated: true)
//
//        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "TermsConditionsViewController") as? TermsConditionsViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func actionResendCode(_ sender : UIButton){
        self.btnResend.isHidden = true
        self.setTimer()
    }
    func sendVerificationCode(){
        showLoader()
        let number = locationCode + phoneNumber
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (verificationID, error) in
            self.hideLoader()
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
          if let error = error {
            self.showAlert(message: error.localizedDescription)
            return
          }
          // Sign in using the verificationID and the code sent to the user
          // ...
        }
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
             })
//             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    
   

}
extension VerifyNumberController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtCode {
          if textField.text?.count ?? 0 == 6{
              btnVerify.backgroundColor = UIColor.green
            
          }
        }
        let maxLength = 6
           let currentString: NSString = (textField.text ?? "") as NSString
           let newString: NSString =
               currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= maxLength
            
        
        return true
    }
    
}
