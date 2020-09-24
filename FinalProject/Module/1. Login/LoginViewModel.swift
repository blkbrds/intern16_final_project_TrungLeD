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
    
    var userName: String?
    var passWord: String?
    
    let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func login(phone: String, pw: String, completion: @escaping APICompletion) {
        networkManager.login(phone: phone, pw: pw) { (customer, error) in
            completion(.success)
        }
    }
}
