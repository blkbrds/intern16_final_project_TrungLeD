//
//  ServiceAPI.swift
//  FinalProject
//
//  Created by Hai Ca on 8/30/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya
// MARK: - Defines
enum APIService {
    case getAllDictrict
    case login(phone: String, pw: String)
    case getAllPitch(page: Int, pageSize: Int)
}
// enum Result
public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public enum APICompletion {
    case success
    case failure(Error)
}
typealias CompletionResult<Value> = (Result<Value>) -> Void
var string = "http://18.188.45.34:8080/trungapi"
extension APIService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: string ) else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        return url
    }
    
    var path: String {
        switch self {
        case.getAllDictrict:
            return "/common/get-all-district"
        case .login:
            return "/common/login"
        case .getAllPitch(let page, let pageSize):
            return "/get-all-pitch?page=\(page)&pageSize=\(pageSize)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllDictrict:
            return .get
        case .login:
            return .post
        case .getAllPitch:
            return .get
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
        return .requestParameters(parameters: ["page": page, "pageSize": pageSize], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["Content-type"] = "application/json"
        return headers
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
