//
//  Customer.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
class Customer: Mappable {
    let id: Int?
    let name: String?
    let phone: String?
    let teamName: String?
    let level: String?
    let star: String?
    let isBlock: String?
    let isDelete: String?
    let countReserve: String?
    let countCancel: String?
    let verify: String?
    let rememberToken: String?
    let description: String?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map){
        id <- map["data.customer.id"]
    }
}
