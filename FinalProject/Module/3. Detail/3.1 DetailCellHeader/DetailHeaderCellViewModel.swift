//
//  DetailHeaderCellViewModel.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class DetailHeaderCellViewModel {
    // MARK: - Properties
    var lat: Double = 0.0
    var long: Double = 0.0
    var address: String = ""
    
    // MARK: - Init
    init(lat: Double, long: Double, address: String = "") {
        self.long = long
        self.lat = lat
        self.address = address
    }
}
