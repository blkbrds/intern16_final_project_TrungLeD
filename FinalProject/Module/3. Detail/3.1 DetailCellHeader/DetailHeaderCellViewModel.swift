//
//  DetailHeaderCellViewModel.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class DetailHeaderCellViewModel {
    var lat: Double = 0.0
    var long: Double = 0.0
    
    init( lat: Double = 0.0, long: Double = 0.0) {
        self.lat = lat
        self.long = long
    }
}
