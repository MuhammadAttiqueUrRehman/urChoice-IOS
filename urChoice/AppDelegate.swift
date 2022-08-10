//
//  AppDelegate.swift
//  urChoice
//
//  Created by Mazhar on 2021-09-02.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        UIApplication.shared.registerForRemoteNotifications()
        if #available(iOS 13.0, *){
            //do nothing we will have a code in SceneceDelegate for this
        } else {
//        gotocall()
        }
      
        return true
    }
    func application(_ application: UIApplication,
                didRegisterForRemoteNotificationsWithDeviceToken
                    deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
            print(deviceTokenString)
        
    }

    func application(_ application: UIApplication,
                didFailToRegisterForRemoteNotificationsWithError
                    error: Error) {
       // Try again later.
    }
    func gotocall(){
        if UserDefaults.standard.object(forKey: "authToken") != nil {
          //Key exists
            let token = defaults.string(forKey: "authToken")
            if token?.isEmpty == false{
               
              let stb = UIStoryboard(name: "Registeration", bundle: nil)
//                let vc = stb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                let vc = stb.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
               
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
                
            }
        }else{
            
            let stb = UIStoryboard(name: "Registeration", bundle: nil)
            let vc = stb.instantiateViewController(withIdentifier: "NavVC") as! NavVC
           
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            
        }
    }
   

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

