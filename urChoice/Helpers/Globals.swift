//
//  Globals.swift
//  GiveAndTake
//
//  Created by Mazhar on 2021-06-12.
//

import Foundation
import TTGSnackbar
var phoneNumber = ""
var locationCode = ""
var countryDialCode:String = "+92"
var countryCode = ""
var country:String = "PK"

let defaults = UserDefaults.standard

struct EndPoint {
    
static let BASE_URL = "http://awon.smartvision.ae/api/service/"
    
}
 func jsonToString(jsonTOConvert: AnyObject) -> String{
    do {
        let data =  try JSONSerialization.data(withJSONObject: jsonTOConvert, options: JSONSerialization.WritingOptions.prettyPrinted)
        if let convertedString = String(data: data, encoding: String.Encoding.utf8) {
            return convertedString
        }
    } catch let myJSONError {
        print(myJSONError)
    }
    return ""
}

func CHECK_EMAIL(testStr:String) -> Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func showSnackBarRed(message: String){
    let snackbar = TTGSnackbar(message: message, duration: .middle)
    snackbar.backgroundColor = UIColor.red
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
}
func showSnackBarGreen(message: String){
    let snackbar = TTGSnackbar(message: message, duration: .middle)
    snackbar.backgroundColor = UIColor.green
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
}
func showSnackBarGray(message: String){
    let snackbar = TTGSnackbar(message: message, duration: .middle)
    snackbar.backgroundColor = UIColor.lightGray
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
}

class PasswordTextField: UITextField {

    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            deleteBackward()
            insertText(text)
        }
        return success
    }

}
