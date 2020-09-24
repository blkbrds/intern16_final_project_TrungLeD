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
    static var shared: NetworkManager = NetworkManager()
    var provider = MoyaProvider<ServiceAPI>()
    
//    func getPosts() -> Single<Any> {
//        return provider.rx.request(.posts)
//            .filterSuccessfulStatusCodes()
//            .mapJSON()
//    }
//
//    func getPostWith(id: Int, completion: @escaping (Post?, Error?) -> ()) {
//        provider.request(.posts) { (result) in
//            switch result {
//            case .success(let response):
//                do {
//                    let rs = try response.filterSuccessfulStatusCodes()
//                    let data = try rs.mapJSON() as? [String: Any]
//                    print(data)
//                } catch {
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func login(phone: String, pw: String, completion: @escaping (Customer?, Error?) -> Void) {
        provider.request(.login(phone: phone, pw: pw)) { result in
            switch result {
            case .success(let response):
                do {
                    // let customer = try response.mapJSON()
                 let customer = try response.map(Customer.self)
                   completion(customer, nil)
                    print(customer)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
