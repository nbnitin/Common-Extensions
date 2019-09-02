//
//  ApiHandler.swift
//  
//
//  Created by Nitin Bhatia on 26/03/19.
//  Copyright © 2019 Nitin Bhatia. All rights reserved.
//

import Foundation
import Alamofire

class ApiHandler{
    var configuration = URLSessionConfiguration.default
//    static var manager = Session()
//    static var apiHandlerShared = ApiHandler()
    var manager: SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20
        return manager
    }
    
    var managerForImageRequest: SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 90
        return manager
    }
//    init(){
//        configuration.timeoutIntervalForRequest = 20 // seconds
//        configuration.timeoutIntervalForResource = 20
//        ApiHandler.manager = URLSession(configuration: configuration)
//    }
    
    func sendPostRequest(url : String, parameters : Parameters, completionHandler: @escaping (_ response : [String : AnyObject],_ error : Error?) -> Void)  {
        
        //Mark:- This below request format sends json data with headers
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json"
        ]
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            
            //debugPrint(response)
            if((response.result.value) != nil) {
                
                // 2. now pass your variable / result to completion handler
                completionHandler(response.result.value as! [String:AnyObject],nil)
                
            } else {
                //response.error and response.result.error both are same
                completionHandler([:],response.error)
            }
        })
        
        //Mark:- Uncomment below part if in case you dont want to send json data with headers
        
        
        //        Alamofire.request(url,method:.post,parameters: parameters,encoding:URLEncoding.httpBody)
        //            .responseJSON(completionHandler: { response in
        //
        //                //
        //                //                debugPrint(response)
        //                //
        //                if((response.result.value) != nil) {
        //
        //
        //
        //                    // 2. now pass your variable / result to completion handler
        //                    completionHandler(response.result.value as! [String:AnyObject],nil)
        //
        //
        //                } else {
        //                    //response.error and response.result.error both are same
        //                    completionHandler([:],response.error)
        //                }
        //            })
        
        
        
        
    }
    
    func sendPostRequestTypeSecond(url : String, parameters : Parameters, completionHandler: @escaping (_ response : [String : AnyObject],_ error : Error?) -> Void)  {
        
        let headers: HTTPHeaders = [
            "AuthToken":(GetSaveUserDetailsFromUserDefault.getDetials()?.AuthToken as? String) ?? ""
        ]
       manager.request(url,method:.post,parameters: parameters,encoding:URLEncoding.httpBody,headers: headers)
            .responseJSON(completionHandler: { response in
                _ =  PrintDebugLog(log: response)

                //
                //                debugPrint(response)
                //
                
                if((response.result.value) != nil) {
                    
                    // check for authentication
                    let value = response.result.value as! [String:AnyObject]
                    if let errorCode = value["ErrorCode"] as? Int{
                        if ( errorCode == 401 ) {
                            DispatchQueue.main.async {
                                
                                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                                    while let presentedViewController = topController.presentedViewController {
                                        topController = presentedViewController
                                    }
                                    
                                    
                                    
                                    let alertController = UIAlertController(title: value["StatusMessage"] as? String, message: "", preferredStyle: .alert)
                                    let alertOk = UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) in
                                        LogoutUser.finalLogout(sourceVc: topController)
                                    })
                                    alertController.addAction(alertOk)
                                    topController.present(alertController, animated: true, completion: nil)
                                    // topController should now be your topmost view controller
                                    
                                }
                            }
                            
                            
                            
                        } else {
                            completionHandler(response.result.value as! [String:AnyObject],nil)
                            
                        }
                        
                    }
                    // 2. now pass your variable / result to completion handler
                    
                    
                } else {
                    completionHandler([:],response.error)
                }
            })
        
        
    }
    
    //for image uploading
    func sendPostRequestTypeSecondForImage(url : String, parameters : Parameters, completionHandler: @escaping (_ response : [String : AnyObject],_ error : Error?) -> Void)  {
        let headers: HTTPHeaders = [
            "AuthToken":(GetSaveUserDetailsFromUserDefault.getDetials()?.AuthToken as? String)!
        ]
        
        
        managerForImageRequest.request(url,method:.post,parameters: parameters,encoding:URLEncoding.httpBody,headers: headers)
            .responseJSON(completionHandler: { response in
                
                //
                //                debugPrint(response)
                //
                
                _ =  PrintDebugLog(log: response)

               
                if((response.result.value) != nil) {
                    
                    // check for authentication
                    let value = response.result.value as! [String:AnyObject]
                    if let errorCode = value["ErrorCode"] as? Int{
                        if ( errorCode == 401 ) {
                            DispatchQueue.main.async {
                                
                                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                                    while let presentedViewController = topController.presentedViewController {
                                        topController = presentedViewController
                                    }
                                    
                                    
                                    
                                    let alertController = UIAlertController(title: value["StatusMessage"] as? String, message: "", preferredStyle: .alert)
                                    let alertOk = UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) in
                                        LogoutUser.finalLogout(sourceVc: topController)
                                    })
                                    alertController.addAction(alertOk)
                                    topController.present(alertController, animated: true, completion: nil)
                                    // topController should now be your topmost view controller
                                    
                                }
                            }
                            
                            
                            
                        } else {
                            completionHandler(response.result.value as! [String:AnyObject],nil)
                            
                        }
                        
                    }
                    // 2. now pass your variable / result to completion handler
                    
                    
                } else {
                    completionHandler([:],response.error)
                }
            })
        
        
    }
    
    
    func makeParameters (data : [String:AnyObject]) -> Parameters{
        return data as Parameters
    }
    
    func makeParameters (data : [String:Any]) -> Parameters{
        return data as Parameters
    }
    
    
    func sendPostRequest(url : String,  completionHandler: @escaping (_ response : [String : AnyObject],_ error : Error?) -> Void)  {
        
        manager.request(url,method:.post)
            .responseJSON(completionHandler: { response in
                
                
                
                if((response.result.value) != nil) {
                    
                    
                    
                    // 2. now pass your variable / result to completion handler
                    completionHandler(response.result.value as! [String:AnyObject],nil)
                    
                    
                } else {
                    //response.error and response.result.error both are same
                    completionHandler([:],response.error)
                }
            })
        
        
    }
    
    func sendPostRequestWithJsonBody (url:String,parameters : Parameters, completionHandler: @escaping (_ response : [String : AnyObject?],_ error: Error?) -> Void){
        
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            // No-op
        }
        
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        manager.request(urlRequest).responseJSON(completionHandler: {response in
            
            if((response.result.value) != nil) {
                
                
                
                // 2. now pass your variable / result to completion handler
                completionHandler(response.result.value as! [String:AnyObject?],nil)
                
                
            } else {
                completionHandler([:],response.error)
            }
            
            
        })
        
    }
    
    func sendGetRequest(url : String, completionHandler: @escaping (_ response : [String : AnyObject],_ error:Error?) -> Void)  {
        let headers: HTTPHeaders = [
            "AuthToken":(GetSaveUserDetailsFromUserDefault.getDetials()?.AuthToken as? String)!
        ]
        
        manager.request(url,method:.get,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { response in
                
                //
                //                debugPrint(response)
                //
               // ApiHandler.manager = Session(configuration: self.configuration)

                if((response.result.value) != nil) {
                    
                    // check for authentication
                    let value = response.result.value as! [String:AnyObject]
                    if let errorCode = value["ErrorCode"] as? Int{
                        if ( errorCode == 401 ) {
                            DispatchQueue.main.async {
                               
                            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                                while let presentedViewController = topController.presentedViewController {
                                    topController = presentedViewController
                                }
                                
                                
                           
                                let alertController = UIAlertController(title: value["StatusMessage"] as? String, message: "", preferredStyle: .alert)
                                let alertOk = UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) in
                                      LogoutUser.finalLogout(sourceVc: topController)
                                })
                                alertController.addAction(alertOk)
                                topController.present(alertController, animated: true, completion: nil)
                                // topController should now be your topmost view controller
                                
                            }
                            }
                            
                           
                    
                        } else {
                            completionHandler(response.result.value as! [String:AnyObject],nil)

                        }
                        
                    }
                    // 2. now pass your variable / result to completion handler
                    
                    
                } else {
                    completionHandler([:],response.error)
                }
            })
        
        
    }
    
    func GetResponseWithoutJSON(url : String, completionHandler: @escaping (_ response : String,_ error:Error?) -> Void)  {
        
        
        
        manager.request(url,method:.get,encoding:URLEncoding.httpBody)
            .responseString(completionHandler: { response in
                
                //
                //                debugPrint(response)
                //
                if((response.result.value) != nil) {
                    
                    
                    
                    // 2. now pass your variable / result to completion handler
                    completionHandler(response.result.value!,nil)
                    
                    
                } else {
                    completionHandler("",response.error)
                }
            })
        
        
    }
    
    
    
    
    
}
