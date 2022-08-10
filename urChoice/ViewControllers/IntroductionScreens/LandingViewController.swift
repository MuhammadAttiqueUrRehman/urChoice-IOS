//
//  LandingViewController.swift
//  uChoice
//
//  Created by iOS Developer on 24/06/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit


class LandingViewController: UIViewController {
    
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var facebookLoginView: UIView!
    @IBOutlet weak var googleLoginView: UIView!
    @IBOutlet weak var mainIconView: UIView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var mobileLoginView : UIView!
    var count = 0
   
    var gameTimer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgLogo.rotate()
//        performLandingAnimations()
        let screenSize: CGRect = UIScreen.main.bounds
        let height = (screenSize.height/2) - 100
        print(height)
        mainIconView.transform = CGAffineTransform(translationX: 0, y: height)
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 5, delay: 0.3, usingSpringWithDamping: 5.0,
//                       initialSpringVelocity: 0, options: [], animations: {
//            self.mainIconView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//            }, completion:
//                { (_) in
//                    self.flashAppName()
//                })
        
        UIView.animate(withDuration: 5) {
            self.mainIconView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        } completion: { Bool in
            self.unHideBottomViewAnimation()
        }

       
    }
    
    
    
    //MARK:- Custom animation methods
    fileprivate func performLandingAnimations() {
        
        let originalTransform = self.mainIconView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.7, y: 0.7)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: -100)
        
        UIView.animate(withDuration: 5, animations: {
            self.mainIconView.transform = scaledAndTranslatedTransform
        }) { (_) in
            
            self.unHideBottomViewAnimation()
        }
    }
    
    fileprivate func unHideBottomViewAnimation() {
        self.bottomContainerView.isHidden = false
        UIView.animate(withDuration: 3, animations: {
            self.bottomContainerView.alpha = 1
        }) { (_) in
            self.flashAppName()
        }
    }
    
    
    
    fileprivate func flashAppName() {
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeAppName), userInfo: nil, repeats: true)
    }
    @objc func changeAppName(){
        self.lblAppName.text = appName[count]
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 0
        self.lblAppName.layer.add(flash, forKey: nil)
        count+=1
        if(count == appName.count){
            count = 0
        }
        
    }
    
    fileprivate func moveToTermsConditions() {
      let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TermsConditionsViewController") as? TermsConditionsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    fileprivate func moveToHomeScreen() {
//        let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.MainContainerViewController) as! MainContainerViewController
//        self.navigationController?.setViewControllers([controller], animated: true)
    }
    
   
    
    //MARK:- Action methods
    @IBAction func actionFacbookLogin(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: StoryboardNames.Registeration, bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "SendVerificationController") as? SendVerificationController
//        self.navigationController?.pushViewController(vc!, animated: true)
        moveToTermsConditions()
       
        
    }
    
    
    
}



extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
