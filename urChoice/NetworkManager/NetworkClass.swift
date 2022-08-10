//
//  NetworkClass.swift
//  urChoice
//
//  Created by Mazhar on 2021-09-18.
//

import Foundation
import Alamofire
let base_url = "https://saeed.agilewebsolutions.net/"
let API_ERROR   = "Error at server, please try again"
let DEFAULTS    = UserDefaults.standard
let headers: HTTPHeaders = [
    "Accept":"application/json",
    "Authorization":"Bearer " + (DEFAULTS.string(forKey: "authToken") ?? "")
]
let staticheaders: HTTPHeaders = [
    "Accept":"application/json",
    "Authorization":"Bearer " + "DWqIVGKcUgHJsxYiF3qLUXXjpXHIaGN8QISNy3AsAN0UHgdWdqh1W0gsNJ8a-0A40D288-EB30-406B-82FA-294D4AE982BD"
]
let headersKEY: HTTPHeaders = [
    "Accept":"application/json",
    "Authorization": "Bearer " + "base64:cLHocpcnbza8oSOunXgTgLe5trNrMbG5oyuFor/SPNA="
]
func postWebCallWithToken(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:AnyObject, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
//    showProgress()
    
    AF.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (response) -> Void in
        if let JSON = response.value {
                 if response.response?.statusCode == 200{
                     completionHandler(JSON as AnyObject, false)
                 }else if(response.response?.statusCode == 401){
                       completionHandler(JSON as AnyObject, true)
                 }else{
                    completionHandler(JSON as AnyObject, true)
                 }
             }
             else{
                 if response.response?.statusCode == 401 {
//                     SVProgressHUD.showInfo(withStatus: "Request timed out.")
                 }
                 else {
                    completionHandler(response.error as AnyObject, true)
                 }
             }
    }// Alamofire ends here
    
    
}
func deleteWebCallWithToken(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:AnyObject, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
//    showProgress()
    
    AF.request(baseurl, method: .delete, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (response) -> Void in
        if let JSON = response.value {
                 if response.response?.statusCode == 200{
                     completionHandler(JSON as AnyObject, false)
                 }else if(response.response?.statusCode == 401){
                       completionHandler(JSON as AnyObject, true)
                 }else{
                    completionHandler(JSON as AnyObject, true)
                 }
             }
             else{
                 if response.response?.statusCode == 401 {
//                     SVProgressHUD.showInfo(withStatus: "Request timed out.")
                 }
                 else {
                    completionHandler(response.error as AnyObject, true)
                 }
             }
    }// Alamofire ends here
    
    
}
func postWebCallWithOutToken(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:AnyObject, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    showProgress()
    
    AF.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON{ (response) -> Void in
        if let JSON = response.value {
                 if response.response?.statusCode == 200{
                    dismissProgress()
                     completionHandler(JSON as AnyObject, false)
                 }else if(response.response?.statusCode == 401){
                    dismissProgress()
                       completionHandler(JSON as AnyObject, true)
                 }else{
                    dismissProgress()
                    completionHandler(JSON as AnyObject, true)
                 }
             }
             else{
                 if response.response?.statusCode == 401 {
                    dismissProgress()
                    completionHandler(response.value as AnyObject, true)
                  
                 }
                 else {
                    dismissProgress()
                    completionHandler(response.value as AnyObject, true)
                 }
             }
    }// Alamofire ends here
    
    
}
func getWebCallWithToken(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:AnyObject, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
//    showProgress()
    
    AF.request(baseurl, method: .get, parameters: params,encoding: URLEncoding.default, headers: headers).responseJSON{ (response) -> Void in
        if let JSON = response.value {
                 if response.response?.statusCode == 200{
//                    dismissProgress()
                     completionHandler(JSON as AnyObject, false)
                 }else if(response.response?.statusCode == 401){
//                    dismissProgress()
                       completionHandler(JSON as AnyObject, true)
                 }else{
//                    dismissProgress()
                       completionHandler(JSON as AnyObject, true)
                 }
             }
             else{
                 if response.response?.statusCode == 401 {
//                    dismissProgress()
                    completionHandler(response.value as AnyObject, true)
                  
                 }
                 else {
//                    dismissProgress()
                    completionHandler(response.value as AnyObject, true)
                 }
             }
    }// Alamofire ends here
    
    
}


//func postWebCallWithToken(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
//{
//    let baseurl = URL(string:url)!
//    showProgress()
//    AF.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (responseData) -> Void in
//        if((responseData.result.value) != nil)
//        {
//            let a = JSON(responseData.result.value)
//            dismissProgress()
//            completionHandler(a, false)
//        }
//        else
//        {
//            let a = JSON()
//            dismissProgress()
//            completionHandler(a, true)
//
//        }
//    }// Alamofire ends here
//
//
//}
func webCallWithImageWithName(url:String, parameters: Parameters, webCallName: String, imgData:Data,imageName: String, sender: UIViewController,completionHandler: @escaping (_ res:AnyObject, _ error:Bool)->Void)
{
   
    AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
           multiPart.append(imgData, withName: imageName, fileName: "image.png", mimeType: "image/png")
        }, to: url, method: .post) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).responseJSON { (response) in
            switch response.result {
            case .success(let resut):
                dismissProgress()
                print("upload success result: \(resut)")
                if response.response?.statusCode == 200{
                completionHandler(response.value as AnyObject, false)
                }else{
                    completionHandler(response.error as AnyObject, true)
                }
            case .failure(let err):
                print("upload err: \(err)")
                dismissProgress()
                completionHandler(response.error as AnyObject, true)
            }
        }
}
func webCallWithImageWithNameHeader(url:String, parameters: Parameters, webCallName: String, imgData:Data,imageName: String, sender: UIViewController,completionHandler: @escaping (_ res:AnyObject, _ error:Bool)->Void)
{
   
    AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
           multiPart.append(imgData, withName: imageName, fileName: "image.png", mimeType: "image/png")
        }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).responseJSON { (response) in
            switch response.result {
            case .success(let resut):
                dismissProgress()
                print("upload success result: \(resut)")
                if response.response?.statusCode == 200{
                completionHandler(response.value as AnyObject, false)
                }else{
                    completionHandler(response.error as AnyObject, true)
                }
            case .failure(let err):
                print("upload err: \(err)")
                dismissProgress()
                completionHandler(response.error as AnyObject, true)
            }
        }
}
func webCallWithVideoHeader(url:String, parameters: Parameters, webCallName: String,videoUrl: URL?, sender: UIViewController,completionHandler: @escaping (_ res:AnyObject, _ error:Bool)->Void)
{
   
    AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
         
if let videourl = videoUrl{
    do {
           let videoData = try Data(contentsOf: videourl)
        let filename = "video." +  (videoUrl?.pathExtension ?? "MOV")
        multiPart.append(videoData, withName: "video", fileName: filename, mimeType: videoUrl?.pathExtension)
       } catch {
           debugPrint("Couldn't get Data from URL: \(videoUrl): \(error)")
       }
           }
        }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).responseJSON { (response) in
            switch response.result {
            case .success(let resut):
                dismissProgress()
                print("upload success result: \(resut)")
                if response.response?.statusCode == 200{
                completionHandler(response.value as AnyObject, false)
                }else{
                    completionHandler(response.error as AnyObject, true)
                }
            case .failure(let err):
                print("upload err: \(err)")
                dismissProgress()
                completionHandler(response.error as AnyObject, true)
            }
        }
}
func webCallWithVideoHeaderFile(url:String, parameters: Parameters, webCallName: String,videoUrl: URL?, sender: UIViewController,completionHandler: @escaping (_ res:AnyObject, _ error:Bool)->Void)
{
   
  
   
    AF.upload(videoUrl!, to: url)
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }
        .responseJSON { (response) in
            switch response.result {
            case .success(let resut):
                dismissProgress()
                print("upload success result: \(resut)")
                if response.response?.statusCode == 200{
                completionHandler(response.value as AnyObject, false)
                }else{
                    completionHandler(response.error as AnyObject, true)
                }
            case .failure(let err):
                print("upload err: \(err)")
                dismissProgress()
                completionHandler(response.error as AnyObject, true)
            }
        }
}
func webCallWithAudioHeader(url:String, parameters: Parameters, webCallName: String,audioUrl: URL?, sender: UIViewController,completionHandler: @escaping (_ res:AnyObject, _ error:Bool)->Void)
{
   
    AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
         
if let audiourl = audioUrl{
    do {
           let videoData = try Data(contentsOf: audiourl)
        let filename = "audio." +  (audioUrl?.pathExtension ?? "MOV")
        multiPart.append(videoData, withName: "audio", fileName: filename, mimeType: audioUrl?.pathExtension)
       } catch {
           debugPrint("Couldn't get Data from URL: \(audioUrl): \(error)")
       }
           }
        }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).responseJSON { (response) in
            switch response.result {
            case .success(let resut):
                dismissProgress()
                print("upload success result: \(resut)")
                if response.response?.statusCode == 200{
                completionHandler(response.value as AnyObject, false)
                }else{
                    completionHandler(response.error as AnyObject, true)
                }
            case .failure(let err):
                print("upload err: \(err)")
                dismissProgress()
                completionHandler(response.error as AnyObject, true)
            }
        }
}
//func webCallWithImageWithNameKey(url:String, parameters: Parameters, webCallName: String, imgData:Data,imageName: String, sender: UIViewController,completionHandler: @escaping (_ res:JSON, _ error:Bool)->Void)
//{
//    showProgress()
//    AF.upload(multipartFormData: { multipartFormData in
//        multipartFormData.append(imgData, withName: imageName,fileName: "image.png", mimeType: "image/png")
//        for (key, value) in parameters
//        {
//            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//        }
//    },to:url,headers: headers)
//    { (result) in
//        switch result {
//        case .success(let upload, _, _):
//            upload.uploadProgress(closure: { (progress) in
//
//                let total = progress.totalUnitCount
//                let obt  = progress.completedUnitCount
//                let per = Double(obt) / Double(total) * 100
//                let perint = Int(per)
//                showProgress(text: "\(perint)" + " " + "%")
//            })
//            upload.responseJSON{ response in
//                let a = JSON(response.result.value)
//                dismissProgress()
//                completionHandler(a, false)
//
//            }
//        case .failure(let encodingError):
//            let a = JSON()
//            dismissProgress()
//            completionHandler(a, true)
//        }
//    }
//
//}





