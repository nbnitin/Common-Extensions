//
//  PrintDebugLog.swift
//  VegetationApp
//
//  Created by Nitin Bhatia on 06/08/19.
//  Copyright © 2019 Nitin Bhatia. All rights reserved.
//

import Foundation

class PrintDebugLog{
    init(title:String="",log:Any){
        #if DEBUG
            print(title,log)
        #endif
    }
}
