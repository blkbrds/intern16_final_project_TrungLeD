//
//  Networkable.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<ServiceAPI> { get }
    
    // MARK: Function
    func login(phone: String, pw: String, completion: @escaping CompletionResult<Customer>)
    
    func getAllPitch(page: Int, pageSize: Int, completion: @escaping CompletionResult<[Pitch]>)
    
    func bookingThePitch(date: String, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int, completion: @escaping CompletionResult<BookingPitch>)
    
    func getResever(idCustomer: Int, page: Int, pageSize: Int, completion: @escaping CompletionResult<[Reserve]>)
}
