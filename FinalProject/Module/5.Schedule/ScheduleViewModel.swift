//
//  ScheduleViewModel.swift
//  FinalProject
//
//  Created by Abcd on 10/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
final class ScheduleViewModel {
    // MARK: - Properties
    let networkManager: NetworkManager
    var reseverTotals: [Reserve] = []
    // MARK: - Init
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MARK: - Function
    func getReserver(completion: @escaping APICompletion) {
        networkManager.getResever(idCustomer: 1, page: 1, pageSize: 100) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let result):
                this.reseverTotals = result
                completion(.success)
            }
        }
    }
}
