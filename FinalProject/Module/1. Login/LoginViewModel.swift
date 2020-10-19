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
    // MARK: Properties
    let networkManager: NetworkManager
    var login: Login = Login()
    // MARK: Init
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MARK: Function
    func login(phone: String, pw: String, completion: @escaping APICompletion) {
        networkManager.login(phone: phone, pw: pw) { [weak self] (result1) in
            guard let this = self else { return }
            switch result1 {
            case .success(let login):
                this.login = login
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
