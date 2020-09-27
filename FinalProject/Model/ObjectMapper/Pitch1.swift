//
//  Pitch1.swift
//  FinalProject
//
//  Created by Abcd on 9/27/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
final class Pitch1 {
       var id: String?
     var name: String?
     var description: String?
     var count: String?
     var isUser: String?

    init(json: JSON) {
        self.id = json["id"] as? String
        self.name = json["name"] as? String
        self.description = json["description"] as? String //json["releaseDate"] as! String
        self.count = json["count"] as? String
        self.isUser = json["isUser"] as? String
    }
}
