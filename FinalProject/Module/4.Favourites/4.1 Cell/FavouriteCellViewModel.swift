//
//  FavouriteCellViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class FavouriteCellViewModel {
    // MARK: - Properties
    var namePitch: String = ""
    var timeAction: String = ""
    var address: String = ""
    
    // MARK: - Init
    init(namePitch: String = "", timeAction: String = "", address: String = "") {
        self.address = address
        self.namePitch = namePitch
        self.timeAction = timeAction
    }
}
