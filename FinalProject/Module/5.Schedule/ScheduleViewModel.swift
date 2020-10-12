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
    var resultCancel: Cancel = Cancel()
    // MARK: - Init
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    // MARK: - Function
    func cancelReserver(idReserve: Int, completion: @escaping APICompletion) {
        networkManager.cancelResever(idCustomer: 1, idReserve: idReserve) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let result):
                completion(.success)
                this.resultCancel = result
            }
        }
    }
    
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
    
    func checkIsEmptyReserver(completion: @escaping (Bool) -> Void) {
        if reseverTotals.isEmpty {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func numberRowOfSection() -> Int {
        return reseverTotals.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> ScheduleCellModel {
        let item = reseverTotals[indexPath.row]
        let detailCell = ScheduleCellModel(resever: item)
        return detailCell
    }
}
