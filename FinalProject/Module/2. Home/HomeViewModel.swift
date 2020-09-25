//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class HomeViewModel {
    var datas: [String] = ["san 1", "san 2", "san3", "san4", "san5", "san6"]
    let networkManager: NetworkManager
    var pitch: [Pitch] = []
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
//    func getAllData() {
//        networkManager.getAllPitch(page: 4, pageSize: 5) { [weak self] result in
//            guard let this = self else { return }
//            switch result {
//            case .failure(let error):
//                break
//            case .success(let result):
//                this.pitch = result
//                print(this.pitch)
//                
//            }
//        }
//    }
}
