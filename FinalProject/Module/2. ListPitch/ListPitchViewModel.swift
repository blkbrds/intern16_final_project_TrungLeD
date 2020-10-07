//
//  CollectionViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift

protocol ListPitchViewModelDelegate: class {
    func syncFavorite(viewModel: ListPitchViewModel, needperformAction action: ListPitchViewModel.Action)
}
class ListPitchViewModel {
    // MARK: - Enum
    enum Action {
        case loadFavorite
    }
    // MARK: - Properties
    var lat: Double {
        return item.pitchType.owner.lat
    }
    var long: Double {
        return item.pitchType.owner.lng
    }
    var namePitch: String {
        return item.name
    }
    var addressPitch: String {
        return item.pitchType.owner.address
    }
    weak var delegate: ListPitchViewModelDelegate?
    var notificationToken: NotificationToken?
    var item: Pitch = Pitch()
    var pitchTotals: [Pitch] = []
    var pitchs: [Pitch] = []
    var realmPitch: [Pitch] = []
    var nameSort: [String] = []
    let networkManager: NetworkManager
    var isBooking: Bool = false
    
    // MARK: - Init
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MAKR: - Function
    func getAllData(completion: @escaping APICompletion) {
        networkManager.getAllPitch(page: 1, pageSize: 100) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion( .failure(error))
            case .success(let result):
                this.pitchTotals = result
                this.pitchs = this.pitchTotals
                completion( .success)
            }
        }
    }
    
    func numberOfRowInSectionByDefault() -> Int {
        return pitchTotals.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> ListPitchCellViewModel {
        let item = pitchs[indexPath.row]
        let viewModel = ListPitchCellViewModel(item: item)
        return viewModel
    }
    
    func getInforPitch(at indexPath: IndexPath) -> DetailViewModel {
        let item = pitchTotals[indexPath.row]
        let detail = DetailViewModel(lat: item.pitchType.owner.lat,
                                     long: item.pitchType.owner.lng,
                                     pitchName: item.name,
                                     address: item.pitchType.owner.address,
                                     phoneNumber: item.pitchType.owner.phone,
                                     timeAction: item.timeUse,
                                     typePitch: item.pitchType.name,
                                     description: item.description1)
        return detail
    }
    
    // MARK: - Realm
    func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Pitch.self).observe({ [weak self] _ in
                guard let this = self else { return }
                if let delegate = this.delegate {
                    this.fetchRealmData()
                    for i in 0..<this.pitchTotals.count {
                        this.pitchTotals[i].isFavorite = this.realmPitch.contains(where: { $0.id == this.pitchTotals[i].id })
                    }
                    delegate.syncFavorite(viewModel: this, needperformAction: .loadFavorite)
                }
            })
        } catch {
            print(error)
        }
    }
    
    func fetchRealmData() {
        do {
            // Realm
            let realm = try Realm()
            // Create results
            let results = realm.objects(Pitch.self)
            // Convert to array
            realmPitch = Array(results)
        } catch {
            print(error)
        }
    }
    func checkFavorite(isFavorite: Bool, id: String) {
        for item in pitchTotals where item.id == id {
            item.isFavorite = isFavorite
        }
    }
    
    func addFavorite(id: String, namePitch: String, addressPitch: String, timeUse: String) {
        do {
            let realm = try Realm()
            let pitch = Pitch()
            pitch.id = id
            pitch.name = namePitch
            pitch.pitchType.owner.address = addressPitch
            pitch.timeUse = timeUse
            try realm.write {
                realm.add(pitch, update: .all)
                checkFavorite(isFavorite: true, id: id )
            }
        } catch {
            print(error)
        }
    }
    
    func unfavorite(id: String) {
        do {
            let realm = try Realm()
            let result = realm.objects(Pitch.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(result)
                checkFavorite(isFavorite: false, id: id)
            }
        } catch {
            print(error)
        }
    }
}
