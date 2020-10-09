//
//  ServiceAPI.swift
//  FinalProject
//
//  Created by Hai Ca on 8/30/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya
// MARK: - Defines
private var token = ""
enum ServiceAPI {
    case getAllDictrict
    case login(phone: String, pw: String)
    case getAllPitch(page: Int, pageSize: Int)
    case bookingPitch(date: String, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int)
}

// enum Result
public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

typealias JSON = [String: Any]
typealias JSArray = [JSON]

typealias APICompletion = (APIResult) -> Void

enum APIResult {
    case success
    case failure(Error)
}
typealias CompletionResult<Value> = (Result<Value>) -> Void

extension ServiceAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "http://18.224.180.166:8080/trungapi" ) else {
            fatalError("Invalid static URL string")
        }
        return url
    }
    
    var path: String {
        switch self {
        case.getAllDictrict:
            return "/common/get-all-district"
        case .login:
            return "/common/login"
        case .getAllPitch:
            return "/common/get-all-pitch"
        case .bookingPitch:
            return "/personal/reserve-pitch"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllDictrict, .getAllPitch(_, _):
            return .get
        case .login, .bookingPitch(_, _, _, _,_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let phone, let pw):
            let phoneData = phone.data(using: String.Encoding.utf8) ?? Data()
            let pwData = pw.data(using: String.Encoding.utf8) ?? Data()
            var formData: [Moya.MultipartFormData] = []
            formData.append(Moya.MultipartFormData(provider: .data(phoneData), name: "phone"))
            formData.append(Moya.MultipartFormData(provider: .data(pwData), name: "password"))
            return .uploadMultipart(formData)
        case .getAllDictrict:
            return .requestPlain
        case .getAllPitch(let page, let pageSize):
            var params: [String: Any] = [:]
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters:["page": page, "pageSize": pageSize], encoding: URLEncoding.default)
        case .bookingPitch(let date, let idCustomer, let idPitch,let idPrice, let idTime):
            var params: [String: Any] = [:]
            params["date"] = date
            params["idCustomer"] = idCustomer
            params["idPitch"] = idPitch
            params["idPrice"] = idPrice
            params["idTime"] = idTime
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .bookingPitch:
            var headers: [String: String] = [:]
            headers["authorization"] = "eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZSI6IjAxMjM0NTY3ODkiLCJleHAiOjE2MDIyOTk0NDR9.rlH-qv7pAncRHEm_SOEWEfu-2eLFH6p_Tgy61zT0AjM"
//             headers["Host"] = "<calculated when request is sent>"
            return headers
        default:
            var headers: [String: String] = [:]
            headers["Content-type"] = "application/json"
            return headers
        }
    }
}

extension Data {
    
    init(forResouce name: String?, ofType ext: String?) {
        @objc class TestClass: NSObject { }
        let bundle = Bundle(for: TestClass.self)
        guard let path = bundle.path(forResource: name, ofType: ext),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("fatalError")
        }
        self = data
    }
}
