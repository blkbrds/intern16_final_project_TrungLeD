//
//  ServiceAPI.swift
//  FinalProject
//
//  Created by Hai Ca on 8/30/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

typealias APICompletion = (Result) -> Void

enum Result {
    case success
    case failure(Error)
}

enum ServiceAPI {
    case getAllDictrict
    case login(phone: String, pw: String)
}

extension ServiceAPI: TargetType {

    var baseURL: URL {
        return URL.init(string: "http://18.188.45.34:8080/")!
    }
    
    var path: String {
        switch self {
        case.getAllDictrict:
            return "trungapi/common/get-all-district"
        case .login:
            return "trungapi/common/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllDictrict:
            return .get
        case .login:
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
        let bundle = Bundle.init(for: TestClass.self)
        guard let path = bundle.path(forResource: name, ofType: ext),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("fatalError")
        }
        self = data
    }
}
