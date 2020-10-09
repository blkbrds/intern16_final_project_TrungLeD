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
    dynamic var imagePitch: String = ""
    dynamic var isFavorite: Bool = false
    dynamic var phone: String = ""
    dynamic var address: String = ""
    dynamic var pitchType: String = ""
    dynamic var lat: Double = 0.0
    dynamic var long: Double = 0.0
    
    // MARK: Init
    required init?(map: Map) {}
    init(id: Int = 0, pitchType: PitchType = PitchType(), name: String = "", description1: String = "", timeUse: String = "", count: Double = 0.0, imagePitch: String = "", isFavorite: Bool, lat: Double, long: Double) {
        self.id = id
        self.long = long
        self.lat = lat
        self.type = pitchType
        self.name = name
        self.description1 = description1
        self.timeUse = timeUse
        self.count = count
        self.imagePitch = imagePitch
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
        timeUse <- map["is_use"]
        count <- map["count"]
        imagePitch <- map["image"]
        phone = type.owner.phone
        address = type.owner.address
        pitchType = type.name
        lat = type.owner.lat
        long = type.owner.lng
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
