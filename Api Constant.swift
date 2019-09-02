//
//  ApiConstant.swift
// 
//  Created by Nitin Bhatia on 02/04/19.
//  Copyright © 2019 Nitin Bhatia. All rights reserved.
//

import Foundation


let apiUrl = AllUrl()
private let baseUrl = "https://"

//production or local
private let websiteName = ""
//production
private let hostAt = ""

private let initial_url = baseUrl + hostAt + websiteName

class AllUrl {
    
    //Mark:- Login and all
    var login = initial_url + "ValidateLogin"
    

}
