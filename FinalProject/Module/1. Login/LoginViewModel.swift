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
    
    func login(phone: String, pw: String) {
        NetworkManager.shared.login(phone: userName ?? "", pw: passWord ?? "") { (customer, error) in
        }
    }
}
