//
//  ListPitchCellViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
final class ListPitchCellViewModel {
    // MARK: - Properties
    var isFavorite: Bool
    var item: Pitch
    var phoneOwner: String {
        return item.type?.owner?.phone ?? ""
    }
    var addressOwner: String {
        return item.type?.owner?.address ?? ""
    }
    var districtOwner: String {
        return item.type?.owner?.district ?? ""
    }
    var verify: String {
        return item.type?.owner?.verify ?? ""
    }
    var lat: Double {
        return item.type?.owner?.lat ?? 0.0
    }
    var long: Double {
        return item.type?.owner?.lng ?? 0.0
    }
    var nameOwer: String {
        return item.type?.owner?.name ?? ""
    }
    var name: String {
        return item.name
    }
    var id: Int {
        return item.id
    }
    var timeUser: String {
        return item.timeUse
    }
    var pitchType: String {
        return item.type?.name ?? ""
    }
    var imagePitch: String {
        return item.imagePitch
    }
    var description1: String {
        return item.description1
    }
    init(item: Pitch) {
        self.item = item
        self.isFavorite = item.isFavorite
    }
}
