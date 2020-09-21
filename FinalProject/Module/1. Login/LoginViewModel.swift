//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class LoginViewModel {
    
    // MARK: - Properties
    var email: String
    var passWord: String
    
    // MARK: - Init
    init(email: String, passWord: String) {
        self.email = email
        self.passWord = passWord
    }
    
}
