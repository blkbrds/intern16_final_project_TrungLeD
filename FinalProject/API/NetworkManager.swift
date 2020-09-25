//
//  NetworkManager.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya
import RxSwift
import ObjectMapper

final class NetworkManager: Networkable {
    // MARK: Properties
    static var shared: NetworkManager = NetworkManager()
    var provider = MoyaProvider<APIService>()
    func login(phone: String, pw: String, completion: @escaping CompletionResult<Customer>) {
        provider.request(.login(phone: phone, pw: pw)) { (result) in
            switch result {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [String: Any],
                        let dataJS = json["data"] as? [String: Any],
                        let customerJS = dataJS["customer"] as? [String: Any] {
                        guard let customer = Mapper<Customer>().map(JSONObject: customerJS) else {
                            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                            return
                        }
                        completion(.success(customer))
                    } else {
                        print("loi")
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllPitch(page: Int, pageSize: Int, completion: @escaping CompletionResult<DataPitch>) {
        provider.request(.getAllPitch(page: 1, pageSize: 100)) { (result) in
            switch result {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [String: Any] {
                        guard let customer = Mapper<DataPitch>().map(JSONObject: json) else {
                            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                            return
                        }
                        print("== ", json, response.request?.url)
                        completion(.success(customer))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
