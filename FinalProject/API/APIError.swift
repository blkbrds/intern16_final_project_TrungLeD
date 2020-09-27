//
//  APIError.swift
//  FinalProject
//
//  Created by Abcd on 9/27/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

class APIError: Mappable {
    var code: Int = 0
    var detail: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code <- map["code"]
        detail <- map["detail"]
    }
}
