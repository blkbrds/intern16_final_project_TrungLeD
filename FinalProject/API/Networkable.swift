//
//  Networkable.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<APIService> { get }
    
    // MARK: Function
    func login(phone: String, pw: String, completion: @escaping CompletionResult<Customer>)
    
    func getAllPitch(page: Int, pageSize: Int, completion: @escaping CompletionResult<NewData>)

}
