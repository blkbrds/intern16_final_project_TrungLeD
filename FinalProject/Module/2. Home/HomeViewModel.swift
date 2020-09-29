//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class HomeViewModel {
    // MARK: Properties
    var datas: [Pitch] = []
    var dataSorts: [Pitch] = []
    var nameSort: [String] = []
    let networkManager: NetworkManager
    
    // MARK: Init
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MAKR: Function
    func getAllData(completion: @escaping APICompletion) {
        networkManager.getAllPitch(page: 1, pageSize: 1000) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion( .failure(error))
            case .success(let result):
                this.datas = result
                
//                this.dataSorts = this.datas.sorted(by: {
//                    guard let name = name else { return }
//                    $0.name.localizedStandardCompare($1.name!) == .orderedAscending
//                })
                
                this.nameSort = this.datas.compactMap({ $0.name })
                this.nameSort = this.nameSort.sorted { $0.compare($1) == .orderedAscending }
                for i in 0..<this.datas.count {
                    let value = Pitch(id: this.datas.first(where: { $0.name == this.nameSort[i] })?.id,
                                      pitchType: this.datas.first(where: { $0.name == this.nameSort[i] })?.pitchType,
                                      name: this.datas.first(where: { $0.name == this.nameSort[i] })?.name,
                                      description: this.datas.first(where: { $0.name == this.nameSort[i] })?.description,
                                      timeUse: this.datas.first(where: { $0.name == this.nameSort[i] })?.timeUse,
                                      count: this.datas.first(where: { $0.name == this.nameSort[i] })?.count,
                                      isUse: this.datas.first(where: { $0.name == this.nameSort[i] })?.isUse)
                    this.dataSorts.append(value)
                }
                completion( .success)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return dataSorts.count
    }
    
    func numberOfRowInSectionByDefault() -> Int {
        return datas.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        let item = dataSorts[indexPath.row]
        let viewModel = HomeCellViewModel(item: item)
        return viewModel
    }
    
    func viewModelForCellByDefault(at indexPath: IndexPath) -> HomeCellViewModel {
        let item = datas[indexPath.row]
        let viewModel = HomeCellViewModel(item: item)
        return viewModel
    }
}
