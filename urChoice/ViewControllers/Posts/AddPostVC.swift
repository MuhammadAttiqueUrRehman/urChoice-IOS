//
//  AddPostVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-03-07.
//

import UIKit

class AddPostVC: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate{

    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var plus3: UIImageView!
    @IBOutlet weak var plus2: UIImageView!
    @IBOutlet weak var plus1: UIImageView!
   
    @IBOutlet weak var txtVu: UITextView!
    var imagePicker = UIImagePickerController()
    var isImagePicker = false
    var selectedImage = UIImage()
    var selectedvideoUrl : URL?
    let userID = defaults.integer(forKey: "userID")
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVu.delegate = self
        setupVu()
        

        // Do any additional setup after loading the view.
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != ""{
            publishBtn.backgroundColor = UIColor().colorForHax("#39CF5D")
            publishBtn.isUserInteractionEnabled = true
        }
        if textView.text.isEmpty {
            txtVu.text = "Write here"
            txtVu.textColor = UIColor.lightGray
            }
    }
    @IBAction func publishBtnTpd(_ sender: Any) {
        SubmitData()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    func setupVu(){
        plus1.layer.cornerRadius = 0.5 * plus1.bounds.size.width
        plus1.clipsToBounds = true
        plus2.layer.cornerRadius = 0.5 * plus2.bounds.size.width
        plus2.clipsToBounds = true
        plus3.layer.cornerRadius = 0.5 * plus3.bounds.size.width
        plus3.clipsToBounds = true
        publishBtn.isUserInteractionEnabled = false
        txtVu.text = "Write here"
        txtVu.textColor = UIColor.lightGray
        txtVu.layer.cornerRadius = 20
    }
    

    @IBAction func photosBtnTpd(_ sender: Any) {
       
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
           
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ [self] (UIAlertAction)in
               print("User click Approve button")
            isImagePicker = true
            imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
           }))
           
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ [self] (UIAlertAction)in
               print("User click Edit button")
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                      print("Button capture")
                isImagePicker = true
              imagePicker.delegate = self
                      imagePicker.sourceType = .savedPhotosAlbum
                      imagePicker.allowsEditing = false
                      
                      present(imagePicker, animated: true, completion: nil)
                  }
           }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        isImagePicker = false
          
           //uncomment for iPad Support
           //alert.popoverPresentationController?.sourceView = self.view

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if isImagePicker{
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           selectedImage = image
            isImagePicker = false
            moveto(isImagetype: true)
         
        }
        }else{
            guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                            return
                        }
                        do {
                            let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                            print(data)
                            selectedvideoUrl = videoUrl
                            moveto(isImagetype: false)
                            self.dismiss(animated: true, completion: nil)
                            
            //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
                        } catch  {
                        }
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func videosBtnTpd(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
           
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ [self] (UIAlertAction)in
               print("User click Approve button")
            isImagePicker = false
            imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.movie"]
            present(imagePicker, animated: true, completion: nil)
           }))
           
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ [self] (UIAlertAction)in
               print("User click Edit button")
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                      print("Button capture")
                isImagePicker = false
              imagePicker.delegate = self
                      imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.mediaTypes = ["public.movie"]
                      imagePicker.allowsEditing = false
                      
                      present(imagePicker, animated: true, completion: nil)
                  }
           }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        isImagePicker = false
          
           //uncomment for iPad Support
           //alert.popoverPresentationController?.sourceView = self.view

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func moveto(isImagetype: Bool){
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "showAddPostVC") as? showAddPostVC
        if isImagetype{
            vc?.image = selectedImage
        }else{
            vc?.videoURL = selectedvideoUrl
        }
        vc?.isImageType = isImagetype
               self.navigationController?.pushViewController(vc!, animated: true)
    }

func SubmitData(){
    showLoader()
    let url = EndPoint.BASE_URL + "post/add"
   
    var param = ["text": txtVu.text!] as [String : Any]
    if txtVu.text == "Write Something"{
       param = ["text": ""] as [String : Any]
    }
       
    
    postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
        if !error{
            print(response)
           hideLoader()
            let status = String(response["status"] as? Int ?? 404)
            let message = String(response["message"] as? String ?? "Error")
            if status != "200"{
                self.alert(message: message)
            }else{
              showSnackBarGray(message: message)
                self.navigationController?.popToRootViewController(animated: true)
              
                
            }
            
            
        }else{
            hideLoader()
            let message = String(response["message"] as? String ?? "Server Error")
            showSnackBarGray(message: message)
//                self.alert(message: error.description)
        }
    }
    
}
}
