//
//  LoginModel.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 18/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import Foundation
import Gloss

class LoginModel {
    
    static let shared = LoginModel()
    
    var loginObject = ClsLogin()
    
    
    
    func askForLocationIfNeeded() {
        
        Locator.shared.authorize()
        
        Locator.shared.locate { result in
            switch result {
            case .Success(let locator):
                if let location = locator.location {
                    
                    let lat = "\(location.coordinate.latitude)"
                    let long = "\(location.coordinate.longitude)"
                    let loc = ["lat": lat, "long" : long]
                    
                    defaults.saveCustomObject(object: loc, key: "savedLocation")
                    
                    print(defaults.getCustomObject(key: "savedLocation"))
                }
            case .Failure(let errorMessage):
                
                if let topVC = UIApplication.getTopMostViewController() {
                    
                    topVC.showAlertViewWith(title: kAlertTitle, message: errorMessage)
                }
            }
        }
    }
    
    func hasLocation(completionHandler: @escaping (Bool) -> ()) {
        
        if let _ = defaults.object(forKey: "savedLocation") {
            
            completionHandler(true)
        }
        else {
            
            if let topVC = UIApplication.getTopMostViewController() {
                
                topVC.showAlertViewWith(title: kAlertTitle, message: "Could get location. Make sure you have enabled.")
            }
            
            completionHandler(false)
        }
    }
    
    
    
    func callLoginAPI(username : String, password : String,completionHandler: @escaping (Bool,String?) -> ()) {
        
        guard let dic = defaults.getCustomObject(key: "savedLocation") as? [String : String] else {
            assertionFailure("Could not get location.")
            return
        }
        
        let latitude = dic["lat"] as! String
        let longitude = dic["long"] as! String
        
        let loginReqObj = LoginRequest(uname: username, pass: password, type: "mycs", lat: latitude, long: longitude, device: ["mobile":deviceModel,"os":deviceOS,"imei" : imei] )
        
        ApiClient.shared.callAPI(url: loginReqObj.getURL(), parameter: loginReqObj.getParams()) { (httpResponse, dictionary, isSuccess, error) in
            
            if (error != nil) {
                
                completionHandler(false,error?.localizedDescription)
                
                
            }
            else {
                
                
                self.loginObject = ClsLogin(json: dictionary as! JSON)!
                
                
                
                if self.loginObject.success {
                    
                    defaults.saveCustomObject(object: self.loginObject.toJSON()!, key: "userObject")
                    
                    completionHandler(true,nil)
                }
                else {
                    
                    completionHandler(false,self.loginObject.message)
                }
                
                
            }
        }
        
        
    }
    
    
}

class LoginRequest {
    
    let username : String!
    let password : String!
    let type : String!
    let latitude : String!
    let longitude : String!
    let device : [String : Any]!
    let url = "/api/user/login"
    
    init(uname : String, pass : String, type : String, lat : String, long : String, device : [String : Any]) {
        
        self.username = uname
        self.password = pass
        self.type = type
        self.latitude = lat
        self.longitude = long
        self.device = device
    }
    
    func getURL() -> String {
        
        return SERVER + url
    }
    
    func getParams() -> [String : Any] {
        print(self.username!)
        
        
        return ["username":self.username!,"password":self.password!,"type":self.type!,"latitude":self.latitude!,"longitude":self.longitude!,"device":self.encodeDeviceObj()]
    }
    
    func encodeDeviceObj() -> String {
        
        let dic = self.device
        
        var jsonString = ""
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dic!,
            options: []) {
            jsonString = String(data: theJSONData,
                                encoding: .ascii)!
            
        }
        
        return jsonString
    }
}
