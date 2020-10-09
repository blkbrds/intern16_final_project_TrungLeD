//
//  BookingPitch.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/8/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

struct BookingPitch: Mappable {
    // MARK: - Properties
    var status: String?
    
    // MARK: - Init
    init?(map: Map) {
    }
    
    init(status: String) {
        self.status = status
    }
    
    init() {}
    mutating func mapping(map: Map) {
        status <- map["status"]
    }
}
