//
//  DataPitch.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
final class DataPitch : Mappable {
    var pitchs: [Pitch]?
    init?(map: Map) { }
    
    func mapping(map: Map) {
        pitchs <- map["data"]
    }
    
    
}
