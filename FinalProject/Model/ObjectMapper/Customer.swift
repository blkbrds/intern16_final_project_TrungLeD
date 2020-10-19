//
//  Customer.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Customer: Mappable {
    // MARK: - Properties
    var id: String?
    var name: String?
    var phone: String?

    // MARK: - Init
    init(id: String = "", name: String = "", phone: String = "") {
        self.id = id
        self.phone = phone
        self.name = name
    }
    required init(map: Map) { }
    // MARK: - Function
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
    }
}
