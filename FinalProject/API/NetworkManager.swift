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
       var provider = MoyaProvider<ServiceAPI>()
    
    // MARK: - Function request
    func cancelResever(idCustomer: Int, idReserve: Int, completion: @escaping CompletionResult<Cancel>) {
        provider.request(.cancelResever(idCustomer: idCustomer, idReserve: idReserve)) { (result) in
            switch result {
            case .success(let response):
                do {
                    if let result = try response.mapJSON() as? JSON {
                        let data: Cancel = Mapper<Cancel>().map(JSONObject: result) ?? Cancel()
                        completion(.success(data))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - getResever
    func getResever(idCustomer: Int, page: Int, pageSize: Int, completion: @escaping CompletionResult<[Reserve]>) {
        provider.request(.getResever(idCustomer: idCustomer, page: 1, pageSize: 100)) { (result) in
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
    
    // MARK: - bookingThePitch
    func bookingThePitch(date: String, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int, completion: @escaping CompletionResult<BookingPitch>) {
        provider.request(.bookingPitch(date: date, idCustomer: idCustomer, idPitch: idPitch, idPrice: idPrice, idTime: idTime)) {  (result) in
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
    
    // MARK: - Login
    func login(phone: String, pw: String, completion: @escaping CompletionResult<Login>) {
        provider.request(.login(phone: phone, pw: pw)) { (result) in
            switch result {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? JSON {
                        let loginJS: Login = Mapper<Login>().map(JSON: json) ?? Login()
                        completion(.success(loginJS))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - getAllPitch
    func getAllPitch(page: Int, pageSize: Int, completion: @escaping CompletionResult<[Pitch]>) {
        provider.request(.getAllPitch(page: 1, pageSize: 100)) { (result) in
            switch result {
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
