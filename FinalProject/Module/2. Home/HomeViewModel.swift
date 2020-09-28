//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var datas: [Pitch] = []
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    func getAllData(completion: @escaping APICompletion) {
        networkManager.getAllPitch(page: 1, pageSize: 1000) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion( .failure(error))
            case .success(let result):
                this.datas = result
                completion( .success)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return datas.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        let item = datas[indexPath.row]
        let viewModel = HomeCellViewModel(item: item)
        return viewModel
    }
}
