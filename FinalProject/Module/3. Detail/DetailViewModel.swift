//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

enum TypeSection {
    case header
    case body
    case infor
    case history
}

final class DetailViewModel {
    enum Action {
        case reloadData
    }
    // MARK: - Properties
    var pitch: Pitch
    var resultBooking: BookingPitch = BookingPitch()
    let networkManager: NetworkManager
    var isFavorite: Bool = false
    // MARK: - Init
    init(pitch: Pitch, networkManager: NetworkManager = NetworkManager.shared) {
        self.pitch = pitch
        self.networkManager = networkManager
    }
    
    // MARK: - Function
    func bookingThePitch(date: String, idCustomer: Int, idPitch: Int, idPrice: Int, idTime: Int, completion: @escaping APICompletion) {
        networkManager.bookingThePitch(date: date, idCustomer: 1, idPitch: idPitch, idPrice: 1, idTime: idTime) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion( .failure(error))
            case .success(let result):
                this.resultBooking = result
                completion(.success)
            }
        }
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
    
    func checkFavorite() -> Bool {
        return Pitch.getByIdInRealms(id: pitch.id) != nil
    }
    
    func unfavorite() -> Error? {
        return pitch.removeInRealms()
    }
    
    func updateFavorite() {
        do {
            let realm = try Realm()
            if realm.objects(Pitch.self).filter(NSPredicate(format: "id = \(pitch.id)")).isEmpty {
                isFavorite = false
            } else {
                isFavorite = true
            }
        } catch {
            return 
        }
        
    }
    
    func addFavorite() -> Error? {
        return pitch.addInRealms()
    }
    
    func viewModelForHeaderCell(at indexPath: IndexPath) -> DetailHeaderCellViewModel {
        let viewModel = DetailHeaderCellViewModel(lat: pitch.type?.owner?.lat ?? 0.0, long: pitch.type?.owner?.lng ?? 0.0, address: pitch.type?.owner?.address ?? "")
        return viewModel
    }
    
    func viewModelForBody(at indexPath: IndexPath) -> DetailBodyCellViewModel {
        let viewModel = DetailBodyCellViewModel(namePitch: pitch.name,
                                                address: pitch.type?.owner?.address ?? "",
                                                phoneNumber: pitch.type?.owner?.phone ?? "",
                                                timeActive: pitch.timeUse)
        return viewModel
    }
    
    func viewModelForInfor(at indexPath: IndexPath) -> DetailInforCellViewModel {
        let viewModel = DetailInforCellViewModel(pitchType: pitch.type?.name ?? "", inforPitch: pitch.type?.owner?.verify ?? "")
        return viewModel
    }
    
    func viewModelForHistory(at indexPath: IndexPath) -> DetailHistoryViewModel {
        let viewModel = DetailHistoryViewModel(description: pitch.description1)
        return viewModel
    }
    
    func viewModelForCustomHeader(at section: Int) -> CustomHeaderViewModel {
        let item = pitch
        let viewModel = CustomHeaderViewModel(title: item.name)
        return viewModel
    }
}
