//
//  SubmitCompModel.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 21/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import Foundation
import Gloss

class SubmitCompModel {
    
    static let shared = SubmitCompModel()
    
    var loginObject = ClsResponse()
    
    func callSubmitComplaint(requestObj : SubmitComplaintRequest,completionHandler: @escaping (Bool,String?) -> ()) {
        
        guard let dic = defaults.getCustomObject(key: "savedLocation") as? [String : String] else {
            assertionFailure("Could not get location.")
            return
        }
        
        let latitude = dic["lat"] as! String
        let longitude = dic["long"] as! String
        
        ApiClient.shared.callAPI(url: requestObj.getURL(), parameter: requestObj.getParams()) { (httpResponse, dictionary, isSuccess, error) in
            
            if (error != nil) {
                
                completionHandler(false,error?.localizedDescription)
                
                
            }
            else {
                
                let response = ClsResponse(json: dictionary as! JSON)
                
                if (response?.success)! {
                    
                    completionHandler(true,response!.message)
                }
                else {
                    
                    completionHandler(false,response!.message)
                }
            }
        }
        
        
    }
    
}

class SubmitComplaintRequest {
    
    let registeredName : String!
    let registeredNumber : String!
    let complainantName : String!
    let complainantNumber : String!
    let longitude : String!
    let latitude : String!
    let asset : String!
    let title : String!
    let desc : String!
    let url = "/api/complaint/submit"
    
    init(rname : String, rnum : String, cname : String,cnum : String, lat : String, long : String, asset : String, title : String, desc : String) {
        
        self.registeredName = rname
        self.registeredNumber = rnum
        self.complainantName = cname
        self.latitude = lat
        self.longitude = long
        self.complainantNumber = cnum
        self.asset = asset
        self.title = title
        self.desc = desc
    }
    
    func getURL() -> String {
        
        return SERVER + url
    }
    
    func getParams() -> [String : Any] {
        
        
        
        return ["registered_name":self.registeredName!,"registered_number":self.registeredNumber!,"asset":asset!,"latitude":self.latitude!,"longitude":self.longitude!,"complainant_name":self.complainantName,"complainant_number":self.complainantNumber,"title" : self.title!,"desc": self.desc!]
    }
    
}


//MARK: - ClsResponse
public class ClsResponse: Glossy {
    public var message : String!
    public var success : Bool!
    
    //MARK: Default Initializer
    init()
    {
        message = ""
        success = false
    }
    
    
    //MARK: Decodable
    public required init?(json: JSON){
        if let message : String = "message" <~~ json {
            self.message = message
        }else{
            self.message = ""
        }
        if let success : Bool = "success" <~~ json {
            self.success = success
        }else{
            self.success = false
        }
        
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "message" ~~> message,
            "success" ~~> success,
            ])
    }
    
}
