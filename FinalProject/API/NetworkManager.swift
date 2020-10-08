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
    func bookingThePitch(date: Date, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int, completion: @escaping CompletionResult<BookingPitch>) {
        provider.request(.bookingPitch(date: date, idCustomer: idCustomer, idPitch: idPitch, idPrice: idPrice, idTime: idTime)) {
         (result) in
            switch result {
            case .success(let respone):
                do {
                    if let json = try respone.mapJSON() as? [String: Any],
                        let dataJS = json["data"] as? String {
                        guard let resultBooking = Mapper<BookingPitch>().map(JSONObject: dataJS) else {
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
                        let dataJS = json["data"] as? [String: Any],
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
