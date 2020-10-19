//
//  Networkable.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

protocol Networkable {
    // MAKR: - Properties
    var provider: MoyaProvider<ServiceAPI> { get }
    
    // MARK: Function
    func getAllPitch(page: Int, pageSize: Int, completion: @escaping CompletionResult<[Pitch]>)
    
    func bookingThePitch(date: String, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int, completion: @escaping CompletionResult<BookingPitch>)
    
    func getResever(idCustomer: Int, page: Int, pageSize: Int, completion: @escaping CompletionResult<[Reserve]>)
    
    func cancelResever(idCustomer: Int, idReserve: Int, completion: @escaping CompletionResult<Cancel>)
    
    func login(phone: String, pw: String, completion: @escaping CompletionResult<Login>)
}
