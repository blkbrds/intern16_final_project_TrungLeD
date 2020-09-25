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
    var nameOwner: String?
    var phone: String?
    var address: String?
    var district: String?
    var lat: Int?
    var long: Int?
    var typePitch: String?
    var namePitch: String?
    var description: String?
    var isUse: String?

    required init(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        nameOwner <- map["pitchType.owner.name"]
        phone <- map["pitchType.owner.phone"]
        address <- map["pitchType.owner.address"]
        district <- map["pitchType.owner.district"]
        lat <- map["pitchType.owner.lat"]
        long <- map["pitchType.owner.lng"]
        typePitch <- map["pitchType.name"]
        namePitch <- map["name"]
        description <- map["description"]
        isUse <- map["is_use"]
    }
}
