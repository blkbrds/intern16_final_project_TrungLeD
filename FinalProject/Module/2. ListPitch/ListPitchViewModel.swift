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
    func loadFavorite(viewModel: ListPitchViewModel, needPerform action: ListPitchViewModel.Action)
}
class ListPitchViewModel {
    // MARK: - Enum
    enum Action {
        case loadFavorite
    }
    // MARK: - Properties
    weak var delegate: ListPitchViewModelDelegate?
    var notificationToken: NotificationToken?
    var item: Pitch = Pitch()
    var pitchData: [Pitch] = []
    var tmpPitchData: [Pitch] = []
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
                this.pitchData = result
                this.tmpPitchData = this.pitchData
                completion( .success)
            }
        }
    }
    
    func numberOfRowInSectionByDefault() -> Int {
        return pitchData.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> ListPitchCellViewModel {
        let item = tmpPitchData[indexPath.row]
        let viewModel = ListPitchCellViewModel(item: item)
        return viewModel
    }
    
    func getInforPitch(at indexPath: IndexPath) -> DetailViewModel {
        let item = pitchData[indexPath.row]
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
                    for i in 0..<this.pitchData.count {
                        this.pitchData[i].favorite =
                            this.realmPitch.contains(where: { $0.idPitch == this.pitchData[i].idPitch })
                    }
                    delegate.loadFavorite(viewModel: this, needPerform: .loadFavorite)
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
    func checkFavorite(favorite: Bool, pitchID: Int) {
        for item in pitchData where item.idPitch == pitchID {
            item.favorite = favorite
        }
    }
    
    func addFavorite(pitchID: Int, namePitch: String, addressPitch: String, timeUse: String) {
        do {
            let realm = try Realm()
            let pitch = Pitch()
            pitch.idPitch = pitchID
            pitch.name = namePitch
            pitch.pitchType.owner.address = addressPitch
            pitch.timeUse = timeUse
            try realm.write {
                realm.add(pitch, update: .all)
                checkFavorite(favorite: true, pitchID: pitchID )
            }
        } catch {
            print(error)
        }
    }
    
    func unfavorite(pitchID: Int) {
        do {
            let realm = try Realm()
            let result = realm.objects(Pitch.self).filter("idPitch1 = '\(pitchID)'")
            try realm.write {
                realm.delete(result)
                checkFavorite(favorite: false, pitchID: pitchID)
            }
        } catch {
            print(error)
        }
    }
}
