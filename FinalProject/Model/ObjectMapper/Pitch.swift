import Foundation
import ObjectMapper
import RealmSwift

@objcMembers class Pitch: Object, Mappable {
    // MARK: Properties
    dynamic var id: Int = 0
    dynamic var type: PitchType = PitchType()
    dynamic var name: String = ""
    dynamic var description1: String = ""
    dynamic var timeUse: String = ""
    dynamic var count: Double = 0.0
    dynamic var isUse: String = ""
    dynamic var isFavorite: Bool = false
    dynamic var phone: String = ""
    dynamic var address: String = ""
    dynamic var pitchType: String = ""
    
    // MARK: Init
    required init?(map: Map) {}
    init(id: Int = 0, pitchType: PitchType = PitchType(), name: String = "", description1: String = "", timeUse: String = "", count: Double = 0.0, isUse: String = "", isFavorite: Bool) {
        self.id = id
        self.type = pitchType
        self.name = name
        self.description1 = description1
        self.timeUse = timeUse
        self.count = count
        self.isUse = isUse
        self.isFavorite = isFavorite
    }
    
    required init() {}
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Function
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["pitchType"]
        name <- map["name"]
        description1 <- map["description"]
        timeUse <- map["image"]
        count <- map["count"]
        isUse <- map["is_use"]
        phone = type.owner.phone
        address = type.owner.address
        pitchType = type.name
    }
}

// MARK: - Realms query
extension Pitch {
    
    static func getByIdInRealms(id: Int) -> Pitch? {
        do {
            let realm = try Realm()
            let results = realm.objects(Pitch.self).filter("id = \(id)")
            return results.first
        } catch {
            return nil
        }
    }
    
    func removeInRealms() -> Error? {
        do {
            let realm = try Realm()
            let result = realm.objects(Pitch.self).filter("id = \(id)")
            try realm.write {
                realm.delete(result)
            }
            return nil
        } catch {
            return error
        }
    }
    
    func addInRealms() -> Error? {
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(Pitch.self, value: self, update: .all)
            }
            return nil
        } catch {
            return error
        }
    }
    
    func editInRealms(handler: () -> Void) -> Error? {
        do {
            let realm = try Realm()
            try realm.write {
                handler()
                realm.add(self)
            }
            return nil
        } catch {
            return error
        }
    }
}
