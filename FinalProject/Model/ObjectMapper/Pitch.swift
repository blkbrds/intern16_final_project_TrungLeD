//
//  Pitch.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Pitch: Mappable {
    var id: String?
    var idOwner: String?
    var nameOwner: String?
    var phone: String?
    var address: String?
    var district: String?
    var lat: String?
    var long: String?
    var typePitch: String?
    var namePitch: String?
    var description: String?
    var count: String?
    var isUse: String?
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["data.id"]
        idOwner <- map["data.pitchType.id"]
        nameOwner <- map["data.pitchType.owner.name"]
        phone <- map["data.pitchType.owner.phone"]
        address <- map["data.pitchType.owner.address"]
        district <- map["data.pitchType.owner.district"]
        lat <- map["data.pitchType.owner.lat"]
        long <- map["data.pitchType.owner.lng"]
        typePitch <- map["data.pitchType.name"]
        namePitch <- map["data.name"]
        description <- map["data.description"]
        count <- map["data.count"]
        isUse <- map["data.is_use"]
    }
}
