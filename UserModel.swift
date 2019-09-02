//
//  User.swift
//  VegetationApp
//
//  Created by Nitin Bhatia on 02/04/19.
//  Copyright © 2019 Nitin Bhatia. All rights reserved.
//

import Foundation

class User:NSObject,Decodable,NSCoding{
    let UserId : Int
    let FirstName : String
    let `Type` : Int
    let Email : String
    let Image : String
    let Status : Int
    let Region : String
    var IsDefaultPassword : Bool
    let AuthToken : String
    
    init(UserId: Int, FirstName: String, Type: Int, Email: String, Image:String, Status:Int,Region:String,IsDefaultPassword:Bool,AuthToken:String){
        self.UserId = UserId
        self.FirstName = FirstName
        self.Type = Type
        self.Email = Email
        self.Image = Image
        self.Status = Status
        self.Region = Region
        self.IsDefaultPassword = IsDefaultPassword
        self.AuthToken = AuthToken
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.UserId = aDecoder.decodeInteger(forKey: "UserId")
       
        self.FirstName =  aDecoder.decodeObject(forKey: "FirstName" ) as! String
        self.Type = aDecoder.decodeInteger(forKey: "Type")
        self.Email = (aDecoder.decodeObject(forKey: "Email") as? String)!
        self.Image = (aDecoder.decodeObject(forKey: "Image") as? String)!
        self.Status = aDecoder.decodeInteger(forKey: "Status")
        self.Region = aDecoder.decodeObject(forKey: ("Region" as? String)!) as! String
        self.IsDefaultPassword = aDecoder.decodeBool(forKey: "IsDefaultPassword")
        self.AuthToken = aDecoder.decodeObject(forKey:"AuthToken") as! String
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.UserId, forKey: "UserId")
        aCoder.encode(self.FirstName, forKey: "FirstName")
        aCoder.encode(self.Email, forKey: "Email")
        aCoder.encode(self.Type, forKey: "Type")
        aCoder.encode(self.Image, forKey: "Image")
        aCoder.encode(self.Status, forKey: "Status")
        aCoder.encode(self.Region, forKey: "Region")
        aCoder.encode(self.IsDefaultPassword, forKey: "IsDefaultPassword")
        aCoder.encode(self.AuthToken, forKey: "AuthToken")

    }
}
