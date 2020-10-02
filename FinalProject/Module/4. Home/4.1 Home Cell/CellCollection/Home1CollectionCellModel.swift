//
//  CollectionCellModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class Home1CollectionCellModel {
    var namePitch: String = ""
    var address: String = ""
    var timeAction: String = ""
    
    init(namePitch: String = "", address: String = "", timeAction: String = "") {
        self.namePitch = namePitch
        self.address = address
        self.timeAction = timeAction
    }
}
