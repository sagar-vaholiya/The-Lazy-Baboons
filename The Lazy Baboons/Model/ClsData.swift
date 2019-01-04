//
//  ClsData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 17, 2018

import Foundation 
import Gloss

//MARK: - ClsData
public class ClsData: Glossy {
    public var asset : String!
    public var assetName : String!
    public var groupName : AnyObject!
    public var id : String!
    public var name : String!
    public var supportEmail : String!
    public var token : String!
    public var type : String!
    public var updatePassword : Bool!
    public var userType : String!
    public var username : String!

	//MARK: Default Initializer 
	init()
	{
        asset = ""
        assetName = ""
        groupName = nil
        id = ""
        name = ""
        supportEmail = ""
        token = ""
        type = ""
        updatePassword = false
        userType = ""
        username = ""
    }


	//MARK: Decodable
	public required init?(json: JSON){
        if let asset : String = "asset" <~~ json {
            self.asset = asset
        }else{
            self.asset = ""
        }
        if let assetName : String = "asset_name" <~~ json {
            self.assetName = assetName
        }else{
            self.assetName = ""
        }
        if let groupName : AnyObject = "group_name" <~~ json {
            self.groupName = groupName
        }else{
        }
        if let id : String = "id" <~~ json {
            self.id = id
        }else{
            self.id = ""
        }
        if let name : String = "name" <~~ json {
            self.name = name
        }else{
            self.name = ""
        }
        if let supportEmail : String = "support_email" <~~ json {
            self.supportEmail = supportEmail
        }else{
            self.supportEmail = ""
        }
        if let token : String = "token" <~~ json {
            self.token = token
        }else{
            self.token = ""
        }
        if let type : String = "type" <~~ json {
            self.type = type
        }else{
            self.type = ""
        }
        if let updatePassword : Bool = "update_password" <~~ json {
            self.updatePassword = updatePassword
        }else{
            self.updatePassword = false
        }
        if let userType : String = "user_type" <~~ json {
            self.userType = userType
        }else{
            self.userType = ""
        }
        if let username : String = "username" <~~ json {
            self.username = username
        }else{
            self.username = ""
        }
        
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
        "asset" ~~> asset,
        "asset_name" ~~> assetName,
        "group_name" ~~> groupName,
        "id" ~~> id,
        "name" ~~> name,
        "support_email" ~~> supportEmail,
        "token" ~~> token,
        "type" ~~> type,
        "update_password" ~~> updatePassword,
        "user_type" ~~> userType,
        "username" ~~> username,
		])
	}

}
