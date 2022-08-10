//
//  BaseViewController.swift
//  urChoice
//
//  Created by Suave on 9/20/21.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    private var animationView: AnimationView?
    var myView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    func showLoader(){
        // 2. Start AnimationView with animation name (without extension)
        let screenSize: CGRect = UIScreen.main.bounds
         myView = UIView(frame: CGRect(x: ((screenSize.width) / 2 - 100), y: ((screenSize.height) / 2 - 150), width: 200, height: 200))
    view.addSubview(myView)
       
          
          animationView = .init(name: "loading")
          
          animationView!.frame = myView.bounds
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
          animationView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
          animationView!.animationSpeed = 0.5
          
        myView.addSubview(animationView!)
          
          // 6. Play animation
          
          animationView!.play()

        // Do any additional setup after loading the view
        
    }
    func hideLoader(){
        animationView!.pause()
        myView.removeFromSuperview()
        
    }

}
