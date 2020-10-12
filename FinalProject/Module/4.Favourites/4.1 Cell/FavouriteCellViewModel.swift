//
//  FavouriteCellViewModel.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class FavouriteCellViewModel {
    // MARK: - Properties
    let pitch: Pitch
    var isFavorite: Bool
    var address: String {
        return pitch.type?.owner?.address ?? ""
    }
    var phoneNumber: String {
        return pitch.type?.owner?.phone ?? ""
    }
    // MARK: - Init
    init(pitch: Pitch) {
        self.pitch = pitch
        self.isFavorite = pitch.isFavorite
    }
    
//    func deleteItemFavorite(completion: @escaping APICompletion) {
//        do {
//            let realm = try Realm()
//            let predicate = NSPredicate(format: "id = \(id)")
//            let result = realm.objects(Pitch.self).filter(predicate)
//            try realm.write {
//                realm.delete(result)
//            }
//            completion(.success)
//        } catch {
//            completion(.failure(error))
//        }
//    }
}
