//
//  Login.swift
//  FinalProject
//
//  Created by Abcd on 10/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

class Login: Mappable {
    // MARK: - Properties
    var data: String?
    var message: String?
    
    // MARK: - Init
    required init?(map: Map) {
    }
    
    init(data: String = "", message: String = "") {
        self.data = data
        self.message = message
    }
    
    // MARK: - Function
    func mapping(map: Map) {
        data <- map["data"]
        message <- map["message"]
    }
}
