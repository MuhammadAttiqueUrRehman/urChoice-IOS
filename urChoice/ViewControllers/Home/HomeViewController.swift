//
//  HomeViewController.swift
//  uChoice
//
//  Created by iOS Developer on 04/07/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie
import EzPopup


protocol UserPrefsDelegate: class {
    func didSelect(gender:String)
    func didSelect(region:String)
    func closeProfileView(shouldEdit:Bool)
    func closeVipSection(isBuying:Bool)
}

class HomeViewController: UIViewController,FooTwoViewControllerDelegate {
   
    
    @IBOutlet weak var micImgVu: UIImageView!
    
    @IBOutlet weak var localVideoView: UIView!
    @IBOutlet weak var ImgCameraView: UIImageView!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblGems : UILabel!
    @IBOutlet weak var lblLikes : UILabel!
    @IBOutlet weak var lblHearts : UILabel!
    
    @IBOutlet weak var regionVu: UIView!
    @IBOutlet weak var friendsVu: UIView!
    
    
    var swipeGesture:UISwipeGestureRecognizer!
    var isChannelJoined = false
    private var animationView: AnimationView?
  
    @IBOutlet weak var friendsAnimatedVu: AnimationView!
    
    @IBOutlet weak var globeAnimatedVu: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVu()
//        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.actionSwipeGesture(_:)))
//        swipeGesture.direction = .left
//        swipeGesture.cancelsTouchesInView = false
//        self.localVideoView.addGestureRecognizer(swipeGesture)
        friendsAnimatedVu.animationSpeed = 0.5
        friendsAnimatedVu.loopMode = .playOnce
        globeAnimatedVu.animationSpeed = 0.5
        globeAnimatedVu.loopMode = .playOnce
        
        
        
        
    }
    func setupVu(){
        regionVu.layer.borderWidth = 2
        regionVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        friendsVu.layer.borderWidth = 2
        friendsVu.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
    }
    func showAnimation(){
        animationView = .init(name: "home")
        
        animationView!.frame = friendsAnimatedVu.bounds
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 0.5
        
      globeAnimatedVu.addSubview(animationView!)
        
        // 6. Play animation
        
        animationView!.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let bgImage = UserDefaults.standard.imageForKey(key: "imageDefaults"){
        imgProfileImage.image = bgImage
        }
        
      
       
//        self.requestCameraPermission()
//        changeUserStatus()
//        setupUserProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        prevLayer?.frame.size = self.localVideoView.frame.size
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
//    deinit {
//        self.localVideoView.removeGestureRecognizer(swipeGesture)
//    }
    
//    func requestCameraPermission(){
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//            case .authorized: // The user has previously granted access to the camera.
//                GCD.async(.Main) {
//                    self.createSession()
//                }
//
//
//            case .notDetermined: // The user has not yet been asked for camera access.
//                AVCaptureDevice.requestAccess(for: .video) { granted in
//                    if granted {
//                        GCD.async(.Main) {
//                            self.createSession()
//                        }
//                    }else{
//                        GCD.async(.Main) {
//                            self.alertToEncourageCameraAccessInitially()
//                        }
//                    }
//                }
//
//            case .denied: // The user has previously denied access.
//                GCD.async(.Main) {
//                    self.alertToEncourageCameraAccessInitially()
//                }
//
//            case .restricted: // The user can't grant access due to restrictions.
//                return
//        @unknown default:
//            return
//        }
//    }
    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for video calling!",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: .init()) { (res) in
                
            }
        }))
        present(alert, animated: true, completion: nil)
    }

    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
            if #available(iOS 11.1, *) {
                let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTelephotoCamera, .builtInTrueDepthCamera, .builtInWideAngleCamera, ], mediaType: .video, position: position)
                if let device = deviceDiscoverySession.devices.first {
                    return device
                }
        } else {
            // Fallback on earlier versions
        }
        
        
        return nil
    }
        
        
        
        func transformOrientation(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
            switch orientation {
            case .landscapeLeft:
                return .landscapeLeft
            case .landscapeRight:
                return .landscapeRight
            case .portraitUpsideDown:
                return .portraitUpsideDown
            default:
                return .portrait
            }
        }
        
        @IBAction func switchCameraSide(sender: AnyObject) {
//            if let sess = session {
//                let currentCameraInput: AVCaptureInput = sess.inputs[0]
//                sess.removeInput(currentCameraInput)
//                var newCamera: AVCaptureDevice
//                if (currentCameraInput as! AVCaptureDeviceInput).device.position == .back {
//                    newCamera = self.cameraWithPosition(position: .front)!
//                } else {
//                    newCamera = self.cameraWithPosition(position: .back)!
//                }
//
//                var newVideoInput: AVCaptureDeviceInput?
//                do{
//                    newVideoInput = try AVCaptureDeviceInput(device: newCamera)
//                }
//                catch{
//                    print(error)
//                }
//
//                if let newVideoInput = newVideoInput{
//                    session?.addInput(newVideoInput)
//                }
//            }
        }

    
    
    
    fileprivate func changeUserStatus() {
        let params = [DictKeys.isAvailableForCall:"false",
                      DictKeys.connectedWith: kBlankString]
       
    }
    
   
    
   
    
   
    
  
   
    @IBAction func actionProfileDetails(_ sender: Any) {
//        alertView = CustomIOSAlertView()
//        alertView?.buttonTitles = nil
//        alertView?.useMotionEffects = true
//        alertView?.touchesEnabled = false
//
//        var demoView:UIView!
//        demoView = UIView()
//        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardNames.Popups, bundle: nil)
//        if let vc = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.ProfileDetailsPopupViewController)as? ProfileDetailsPopupViewController {
//            vc.delegate = self
//            self.objAlertVC = vc
//            demoView.frame = CGRect(x:0, y:0, width:ScreenSize.SCREEN_WIDTH - 20, height:ScreenSize.SCREEN_HEIGHT)
//            vc.view.frame = CGRect(x:0, y:0, width:ScreenSize.SCREEN_WIDTH - 20, height:ScreenSize.SCREEN_HEIGHT)
//            demoView.addSubview(vc.view)
//            self.alertView?.containerView = demoView
//        }
//
//        self.alertView?.show()
    }
    
    @IBAction func actionStore(_ sender: Any) {
//        let st = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
//        let vc = st.instantiateViewController(withIdentifier: "FriendRequestController") as? FriendRequestController
//        vc?.modalPresentationStyle = .fullScreen
//        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func actionGems(_ sender: Any) {
//        let st = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
//        let vc = st.instantiateViewController(withIdentifier: "ShopViewController") as? ShopViewController
//        vc?.modalPresentationStyle = .fullScreen
//        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func actionGenderPrefs(_ sender: Any) {
//        alertView = CustomIOSAlertView()
//        alertView?.buttonTitles = nil
//        alertView?.useMotionEffects = true
//        alertView?.touchesEnabled = false
//
//        var demoView:UIView!
//        demoView = UIView()
//        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardNames.Popups, bundle: nil)
//        if let vc = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.GenderPrefsPopupViewController)as? GenderPrefsPopupViewController {
//            vc.delegate = self
//            self.objAlertVC = vc
//            demoView.frame = CGRect(x:0, y:0, width:300, height:340)
//            vc.view.frame = CGRect(x:0, y:0, width:300, height:340)
//            demoView.addSubview(vc.view)
//            self.alertView?.containerView = demoView
//        }
//
//        self.alertView?.show()
    }
    
    @IBAction func actionRegionPrefs(_ sender: Any) {
//        alertView = CustomIOSAlertView()
//        alertView?.buttonTitles = nil
//        alertView?.useMotionEffects = true
//        alertView?.touchesEnabled = false
//
//        var demoView:UIView!
//        demoView = UIView()
//        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardNames.Popups, bundle: nil)
//        if let vc = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.RegionalPrefsPopupViewController)as? RegionalPrefsPopupViewController {
//            vc.delegate = self
//            self.objAlertVC = vc
//            demoView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width-40                           , height:self.view.frame.size.height-40)
//            vc.view.frame = CGRect(x:0, y:0, width:self.view.frame.size.width-40                           , height:self.view.frame.size.height-40)
//            demoView.addSubview(vc.view)
//            self.alertView?.containerView = demoView
//        }
//
//        self.alertView?.show()
    }
    
    @IBAction func actionSwitchCamera(_ sender: Any) {
//        if let sess = session {
//            let currentCameraInput: AVCaptureInput = sess.inputs[0]
//            sess.removeInput(currentCameraInput)
//            var newCamera: AVCaptureDevice
//            if (currentCameraInput as! AVCaptureDeviceInput).device.position == .back {
//                newCamera = self.cameraWithPosition(position: .front)!
//            } else {
//                newCamera = self.cameraWithPosition(position: .back)!
//            }
//
//            var newVideoInput: AVCaptureDeviceInput?
//            do{
//                newVideoInput = try AVCaptureDeviceInput(device: newCamera)
//            }
//            catch{
//                print(error)
//            }
//
//            if let newVideoInput = newVideoInput{
//                session?.addInput(newVideoInput)
//            }
//        }
    }
    
    @IBAction func actionEffect(_ sender: Any) {
    }
    
    @IBAction func actionVipMembership(_ sender: Any) {
//        alertView = CustomIOSAlertView()
//        alertView?.buttonTitles = nil
//        alertView?.useMotionEffects = true
//        alertView?.touchesEnabled = false
//
//        var demoView:UIView!
//        demoView = UIView()
//        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardNames.Popups, bundle: nil)
//        if let vc = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.VipMemberPopupViewController)as? VipMemberPopupViewController {
//            vc.delegate = self
//            self.objAlertVC = vc
//            demoView.frame = CGRect(x:0, y:0, width:ScreenSize.SCREEN_WIDTH - 50, height:ScreenSize.SCREEN_HEIGHT - 50)
//            vc.view.frame = CGRect(x:0, y:0, width:ScreenSize.SCREEN_WIDTH - 50, height:ScreenSize.SCREEN_HEIGHT - 50)
//            demoView.addSubview(vc.view)
//            self.alertView?.containerView = demoView
//        }
//
//        self.alertView?.show()
    }
    @IBAction func regionBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "RegionalVC") as? RegionalVC
              
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func genderBtnTpd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "GenderPickerPopUp") as! GenderPickerPopUp
              // init YourViewController
              let contentViewController = vc

              let popupVC = PopupViewController(contentController: contentViewController, popupWidth: 400, popupHeight: 370)

              present(popupVC, animated: true)
    }
    @IBAction func friendsBtnTpd(_ sender: Any) {
//        showAnimation()
        friendsAnimatedVu.play()
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsVC
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func globeBtnTpd(_ sender: Any) {
        globeAnimatedVu.play()
    }
    
    
    
    @IBAction func profilePicBtnTpd(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
//                  let vc = storyboard.instantiateViewController(withIdentifier: "editProfileVC") as! editProfileVC
//              // init YourViewController
//        vc.delegate = self
//              let contentViewController = vc
//
//              let popupVC = PopupViewController(contentController: contentViewController, popupWidth: 400, popupHeight: 700)
//
//              present(popupVC, animated: true)
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "editProfileVC") as? editProfileVC
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    func myVCDidFinish() {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func micBntTpd(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            micImgVu.image = UIImage(named: "micon")
        }else{
            sender.isSelected = true
            micImgVu.image = UIImage(named: "micoff")
        }
    }
    
}

