//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

enum TypeSection {
    case header
    case body
    case infor
    case history
}
final class DetailViewModel {
    
    var pitch: Pitch?
    // MARK: Properties
    var id: Int = 0
    var lat: Double = 0.0
    var long: Double = 0.0
    var pitchName: String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var timeAction: String = ""
    var typePitch: String = ""
//    var price: String?
    var description: String = ""
    

    init(lat: Double = 0.0,
         long: Double = 0.0,
         pitchName: String = "",
         address: String =  "",
         phoneNumber: String = "",
         timeAction: String = "",
         typePitch: String = "",
//         price: String,
         description: String = "") {
        self.lat = lat
        self.long = long
        self.pitchName = pitchName
        self.address = address
        self.phoneNumber = phoneNumber
        self.timeAction = timeAction
        self.typePitch = typePitch
//        self.price = price
        self.description = description
    }
    
    func typeSectionLoad(number: Int) -> TypeSection {
        switch number {
        case 0:
            return .header
        case 1:
            return .body
        case 2:
            return .infor
        default:
            return .history
        }
    }
    
    func viewModelForHeaderCell(at indexPath: IndexPath) -> DetailHeaderCellViewModel {
        let viewModel = DetailHeaderCellViewModel(lat: lat, long: long)
        return viewModel
    }
    
    func viewModelForBody(at indexPath: IndexPath) -> DetailBodyCellViewModel {
        let viewModel = DetailBodyCellViewModel(namePitch: pitchName, address: address, phoneNumber: phoneNumber, timeActive: timeAction)
        return viewModel
    }
    
    func viewModelForInfor(at indexPath: IndexPath) -> DetailInforCellViewModel {
           let viewModel = DetailInforCellViewModel(pitchType: typePitch)
           return viewModel
       }
    
    func viewModelForHistory(at indexPath: IndexPath) -> DetailHistoryViewModel {
        let viewModel = DetailHistoryViewModel(description: description)
        return viewModel
    }
}
