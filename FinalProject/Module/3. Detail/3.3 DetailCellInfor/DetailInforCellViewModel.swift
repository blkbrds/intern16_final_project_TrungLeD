//
//  DetailInforCellViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class DetailInforCellViewModel {
    // MARK: Properties
    var pitchType: String = ""
    var inforPitch: String = ""
    
    // MARK: Init
    init(pitchType: String = "", inforPitch: String = "") {
        self.pitchType = pitchType
        self.inforPitch = inforPitch
    }
}
