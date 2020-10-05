//
//  CollectionViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class ListPitchViewModel {
    
    // MARK: - Properties
    var item: Pitch = Pitch()
    var pitchData: [Pitch] = []
    var tmpPitchData: [Pitch] = []
    var nameSort: [String] = []
    let networkManager: NetworkManager
    var isBooking: Bool = false
    
    // MARK: - Init
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MAKR: - Function
    func getAllData(completion: @escaping APICompletion) {
        networkManager.getAllPitch(page: 1, pageSize: 100) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion( .failure(error))
            case .success(let result):
                this.pitchData = result
                this.tmpPitchData = this.pitchData
                completion( .success)
            }
        }
    }
    
    func numberOfRowInSectionByDefault() -> Int {
        return pitchData.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> ListPitchCellViewModel {
        let item = tmpPitchData[indexPath.row]
        let viewModel = ListPitchCellViewModel(item: item)
        return viewModel
    }
    
    func getInforPitch(at indexPath: IndexPath) -> DetailViewModel {
        let item = pitchData[indexPath.row]
        let detail = DetailViewModel(lat: item.pitchType.owner.lat,
                                     long: item.pitchType.owner.lng,
                                     pitchName: item.name,
                                     address: item.pitchType.owner.address,
                                     phoneNumber: item.pitchType.owner.phone,
                                     timeAction: item.timeUse,
                                     typePitch: item.pitchType.name,
                                     description: item.description)
        return detail
    }
}
