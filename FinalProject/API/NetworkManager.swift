//
//  NetworkManager.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya
import RxSwift

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<ServiceAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    func getPosts() -> Single<Any> {
        return provider.rx.request(.posts)
            .filterSuccessfulStatusCodes()
            .mapJSON()
    }

    func getPostWith(id: Int, completion: @escaping (Post?, Error?) -> ()) {
        provider.request(.posts) { (result) in
            switch result {
            case .success(let response):
                do {
                    let rs = try response.filterSuccessfulStatusCodes()
                    let data = try rs.mapJSON() as? [String: Any]
                    print(data)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
