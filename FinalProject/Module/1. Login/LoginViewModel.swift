//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class LoginViewModel {
    
    let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func login(phone: String, pw: String, completion: @escaping (APICompletion) -> Void ) {
        networkManager.login(phone: phone, pw: pw) { result in
            switch result {
            case .success(let customer):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}