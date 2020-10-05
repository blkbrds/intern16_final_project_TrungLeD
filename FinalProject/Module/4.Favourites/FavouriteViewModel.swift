//
//  FavouriteViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavouriteViewModelDelegate: class {
    func favourite(viewModel: FavouriteViewModel, needPerform action: FavouriteViewModel.Action)
}

class FavouriteViewModel {
    // MARK: - Enum
    enum Action {
        case loadData
        case failure(Error)
    }
    
    // MARK: - Properties
    weak var delegate: FavouriteViewModelDelegate?
    private var notificationToken: NotificationToken?
    var pitchs: [Pitch] = []
    var isEmpty: Bool {
        return pitchs.isEmpty
    }
    
    // MARK: - Function
    func numberOfRowInSection() -> Int {
        return pitchs.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> FavouriteCellViewModel {
        let item = pitchs[indexPath.row]
        let detailCell = FavouriteCellViewModel(pitch: item)
        return detailCell
    }
    
    func getDataFromRealm(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let tempData = realm.objects(Pitch.self)
            pitchs = Array(tempData)
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    
    func setupObserver() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Pitch.self).observe({ (_) in
                if let delegate = self.delegate {
                    delegate.favourite(viewModel: self, needPerform: .loadData)
                }
            })
        } catch {
            delegate?.favourite(viewModel: self, needPerform: .failure(error))
        }
    }
    
    func removeAllItem(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let tempData = realm.objects(Pitch.self)
            try realm.write{
                realm.delete(tempData)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    
    func removeFavouriteItem(id: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let tempData = realm.objects(Pitch.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(tempData)
            }
            completion(.success)
        } catch { completion(.failure(error))
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> DetailViewModel {
        let item = pitchs[indexPath.row]
        let detail = DetailViewModel(lat: item.pitchType.owner.lat,
                                     long: item.pitchType.owner.lng,
                                     pitchName: item.name,
                                     address: item.pitchType.owner.address,
                                     phoneNumber: item.pitchType.owner.phone,
                                     timeAction: item.timeUse,
                                     typePitch: item.pitchType.name,
                                     description: item.description)
        return detail
    }
}
