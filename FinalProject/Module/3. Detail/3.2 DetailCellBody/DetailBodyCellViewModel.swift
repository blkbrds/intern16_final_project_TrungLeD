//
//  DetailBodyCellViewModel.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
class DetailBodyCellViewModel {
    // MARK: Properties
//    var item: Pitch = Pitch()
    var namePitch: String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var timeActive: String = ""
    var index: Int = 0
    
    // MARK: Init
    init(namePitch: String = "", address: String = "", phoneNumber: String = "", timeActive: String = "", index: Int = 0) {
        self.address = address
        self.namePitch = namePitch
        self.phoneNumber = phoneNumber
        self.timeActive = timeActive
        self.index = index
    }
}
