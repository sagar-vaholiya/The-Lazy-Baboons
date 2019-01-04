//
//  ClsLogin.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 17, 2018

import Foundation 
import Gloss

//MARK: - ClsLogin
public class ClsLogin: Glossy {
    public var data : ClsData!
    public var message : String!
    public var success : Bool!

	//MARK: Default Initializer 
	init()
	{
        data = ClsData()
        message = ""
        success = false
    }


	//MARK: Decodable
	public required init?(json: JSON){
        if let data : ClsData = "data" <~~ json {
            self.data = data
        }else{
            self.data = ClsData()
        }
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
        "data" ~~> data,
        "message" ~~> message,
        "success" ~~> success,
		])
	}

}
