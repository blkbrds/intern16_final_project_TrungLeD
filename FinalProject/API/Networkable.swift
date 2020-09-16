//
//  Networkable.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya
import RxSwift

protocol Networkable {
    var provider: MoyaProvider<ServiceAPI> { get }
    
    func getPosts() -> Single<Any>
    func getPostWith(id: Int, completion: @escaping (Post?, Error?) -> ())
}
