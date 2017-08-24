//
//  AuthCodeGenerator.swift
//  EazyCarCare
//
//  Created by Umesh Chauhan on 28/04/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import Foundation
import CryptoSwift
import Security


private let BASE_AUTH_KEY = "bZWAlvafAGzKsi9oNrmBdR1Q9qee4nwhY2y";

extension Dictionary{
    
    func toJSON() -> String{
        let dic = self
        var expected : String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            // let data = try JSONSerialization.data(withJSONObject: expected, options: [])
            
            expected = String(data: jsonData, encoding: .utf8)!
            expected = String(expected.characters.filter { !" \n\t\r".characters.contains($0) })
           
           
            // here "decoded" is of type `Any`, decoded from JSON data
            
            // you can now cast it with the right type
//            if let dictFromJSON = jsonData as? [String:String] {
//                // use dictFromJSON
//            }
        } catch {
            print(error.localizedDescription)
        }
         return expected
    }
    
}

extension String{
    
    func getAuthCodeFromString()->String{
        let jsonString = self
        var base64String : String = ""
            
            let bytes = Array((jsonString).utf8)
                       
            do{
               let content = try HMAC(key: BASE_AUTH_KEY, variant: .sha256).authenticate(bytes)
                base64String =  content.toBase64()!
            }
            catch _{}
            return base64String
      }
  
}
