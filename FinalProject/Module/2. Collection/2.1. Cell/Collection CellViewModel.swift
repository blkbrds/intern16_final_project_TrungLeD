//
//  CollectionCellViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
final class CollectionCellViewModel {
    
    // MARK: Properties
    var item: Pitch
    var phoneOwner: String? {
        return item.pitchType?.owner?.phone
    }
    var addressOwner: String? {
        return item.pitchType?.owner?.address
    }
    var districtOwner: String? {
        return item.pitchType?.owner?.district
    }
    var verify: String? {
        return item.pitchType?.owner?.verify
    }
    var lat: Double? {
        return item.pitchType?.owner?.lat
    }
    var long: Double? {
        return item.pitchType?.owner?.lng
    }
    var nameOwer: String? {
        return item.pitchType?.owner?.name
    }
    var name: String? {
        return item.name
    }
    var id: Int? {
        return item.id
    }
    var timeUser: String? {
        return item.timeUse
    }
    
    init(item: Pitch) {
        self.item = item
    }
}
