//
//  Cancel.swift
//  FinalProject
//
//  Created by Abcd on 10/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Cancel: Mappable {
    var data: String = ""
    var message: String = ""

    init?(map: Map) {}
    init() {}

    func mapping(map: Map) {
        data <- map["data"]
        message <- map["message"]
    }

}
