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
        case failure(Error)
    }
    // MARK: - Properties
    weak var delegate: ListPitchViewModelDelegate?
    var notificationToken: NotificationToken?
    var item: Pitch = Pitch()
    var resultBooking: BookingPitch = BookingPitch()
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
        let detail = DetailViewModel(pitch: item)
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
            delegate?.syncFavorite(viewModel: self, needperformAction: .failure(error))
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
            return
        }
    }
    
    func checkFavorite(isFavorite: Bool, id: Int) {
        for item in pitchTotals where item.id == id {
            item.isFavorite = isFavorite
        }
    }
    
    func addFavorite(index: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let pitchTemp = pitchTotals[index]
            let pitchRealm = Pitch(id: pitchTemp.id,
                                   type: pitchTemp.type ?? PitchType(),
                                   name: pitchTemp.name,
                                   description1: pitchTemp.description1,
                                   timeUse: pitchTemp.timeUse,
                                   count: pitchTemp.count,
                                   imagePitch: pitchTemp.imagePitch,
                                   isFavorite: pitchTemp.isFavorite,
                                   lat: pitchTemp.lat,
                                   long: pitchTemp.long)
            try realm.write {
                realm.create(Pitch.self, value: pitchRealm, update: .all)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    
    func unfavorite(id: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = \(id)")
            let result = realm.objects(Pitch.self).filter(predicate)
            try realm.write {
                realm.delete(result)
                checkFavorite(isFavorite: false, id: id)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
