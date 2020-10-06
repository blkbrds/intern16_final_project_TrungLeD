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
    }
    init() {
        setupObserve()
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
    
    func fetchRealmData(completion: @escaping (Bool) -> Void) {
        do {
            // Realm
            let realm = try Realm()
            // Create results
            let results = realm.objects(Pitch.self)
            // Convert to array
            pitchs = Array(results)
            // Call back
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    private func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Pitch.self).observe({ (_) in
                if let delegate = self.delegate {
                    delegate.favourite(viewModel: self, needPerform: .loadData)
                }
            })
        } catch {
            print(error)
        }
    }
    
    func checkFavoriteData(completion: @escaping (Bool) -> Void) {
        if pitchs.isEmpty {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func deleteItemFavorite(id: String, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Pitch.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(results)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }

    func deleteAllItem(completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Pitch.self)
            try realm.write {
                realm.delete(results)
            }
            completion(true)
        } catch {
            completion(false)
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
