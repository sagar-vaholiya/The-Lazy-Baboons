//
//  ApiClient.swift
//  Wolfgang MVVM New
//
//  Created by Sagar on 28/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD
import IQKeyboardManagerSwift

typealias alertCallBack = (_ alertType :AlertType,_ message : String) -> Swift.Void

// MARK: Callbacks
var onShowAlert: alertCallBack?
var reloadView : (() -> Swift.Void)?


var SERVER : String = "http://13.232.35.230"

var kAlertTitle = "The Lazy Baboons"

enum AlertType {
    
    case FAILURE
    case SUCCESS
    case JUSTINFORM
}


class ApiClient : NSObject {
    
    static let shared = ApiClient()
    
    
    lazy var Manager: Alamofire.SessionManager = {
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 8
        configuration.timeoutIntervalForResource = 20
        
        let manager = Alamofire.SessionManager(
            configuration: configuration
        )
        
        return manager
    }()
    
    
    func callAPI(url:String,parameter: [String : Any]?,httpMethod : HTTPMethod = .post,header : NSMutableDictionary? = nil,completionHandler: @escaping (HTTPURLResponse?,Any?, Bool, Error?)->Swift.Void) {
        
        
        if !isConnectedToInternet() {
            
            showAPIMessageAlert(message: "Internet connection is not available.")
        }
        
//        LLSpinner.spin()
        
        if let topVC = UIApplication.getTopMostViewController() {
            
            topVC.view.showProgressView()
        }
        
        
        
        
        let dictHeaders = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        
        Manager.request(url, method: httpMethod, parameters: parameter!, encoding: URLEncoding.default, headers: dictHeaders).responseJSON { (response) in
            
            if let topVC = UIApplication.getTopMostViewController() {
                topVC.view.hideProgressView()
            }
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    //                    print(response.result.value!)
                    
                    completionHandler(response.response,data,true,nil)
                }
                break
                
            case .failure(_):
                //                print(response.result.error ?? "")
                
                completionHandler(nil,nil,false,response.result.error)
                
                break
                
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        
    }
    
    
    
    // MARK: - Rechability Functions
    
    func isConnectedToInternet() ->Bool {
        return AIReachabilityManager.sharedManager.isInternetAvailableForAllNetworks()
    }
    
    // MARK: - Alert Functions
    
    func showAPIMessageAlert (message : String)
    {
        let alert = UIAlertController(title: kAlertTitle, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
            
        })
        
        if let topVC = UIApplication.getTopMostViewController() {
            
            topVC.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

