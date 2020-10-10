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
    // MARK: - Function request
    func getResever(idCustomer: Int, page: Int, pageSize: Int, completion: @escaping CompletionResult<[Reserve]>) {
        provider.request(.getResever(idCustomer: idCustomer, page: 1, pageSize: 100)) {
            (result) in
            switch result {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? JSON, let data1JS = json["data"] as? JSArray {
                        let reseverJS: [Reserve] = Mapper<Reserve>().mapArray(JSONArray: data1JS)
                        completion(.success(reseverJS))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func bookingThePitch(date: String, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int, completion: @escaping CompletionResult<BookingPitch>) {
        provider.request(.bookingPitch(date: date, idCustomer: idCustomer, idPitch: 1, idPrice: idPrice, idTime: idTime)) {  (result) in
            switch result {
            case .success(let respone):
                do {
                    if let json = try respone.mapJSON() as? JSON,
                        let dataJS = json["data"] as? JSON {
                        guard let resultBooking = Mapper<BookingPitch>().map(JSON: dataJS ) else {
                            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                            return
                        }
                        completion(.success(resultBooking))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Properties
    static var shared: NetworkManager = NetworkManager()
    var provider = MoyaProvider<ServiceAPI>()
    
    // MARK: Function
    func login(phone: String, pw: String, completion: @escaping CompletionResult<Customer>) {
        provider.request(.login(phone: phone, pw: pw)) { (result) in
            switch result {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [String: Any],
                        let dataJS = json["data"] as? JSON,
                        let customerJS = dataJS["customer"] as? [String: Any] {
                        guard let customer = Mapper<Customer>().map(JSONObject: customerJS) else {
                            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                            return
                        }
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
    
    func getAllPitch(page: Int, pageSize: Int, completion: @escaping CompletionResult<[Pitch]>) {
        provider.request(.getAllPitch(page: 1, pageSize: 100)) { (result1) in
            switch result1 {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? JSON, let dataJS = json["data"] as? JSArray {
                        let pitchJS: [Pitch] = Mapper<Pitch>().mapArray(JSONArray: dataJS)
                        completion(.success(pitchJS))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion( .failure(error))
            }
        }
    }
}

// MARK: - Extension
//extension BookingPitch: TargetType, AccessTokenAuthorizable {
//    case targetThatNeedsBearerAuth
//    case targetThatNeedsBasicAuth
//    case targetThatNeedsCustomAuth
//    case targetDoesNotNeedAuth
//
//    var authorizationType: AuthorizationType? {
//        switch self {
//            case .targetThatNeedsBearerAuth:
//                return .bearer
//            case .targetThatNeedsBasicAuth:
//                return .basic
//            case .targetThatNeedsCustomAuth:
//                return .custom("CustomAuthorizationType")
//            case .targetDoesNotNeedAuth:
//                return nil
//            }
//        }
//}
