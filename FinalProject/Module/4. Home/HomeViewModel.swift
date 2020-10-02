//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
class HomeViewModel {
    var pitchData: [Pitch] = []
    
    func numberOfRowInSectionByDefault() -> Int {
        return pitchData.count
    }
    
    //   func viewModelForCell(at indexPath: IndexPath) -> Home1CollectionCellModel {
    //       let item = pitchData[indexPath.row]
    //       let viewModel = Home1CollectionCellModel(namePitch: <#T##String#>, address: <#T##String#>, timeAction: <#T##String#>)
    //       return viewModel
    //   }
    
    func getInforPitch(at indexPath: IndexPath) -> DetailViewModel {
        let item = pitchData[indexPath.row]
        let detail = DetailViewModel(lat: item.pitchType.owner.lat, long: item.pitchType.owner.lng, pitchName: item.name, address: item.pitchType.owner.address, phoneNumber: item.pitchType.owner.phone, timeAction: item.timeUse, typePitch: item.pitchType.name,  description: item.description)
        return detail
    }
}
