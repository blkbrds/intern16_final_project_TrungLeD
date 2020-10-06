import Foundation
import ObjectMapper
import RealmSwift

@objcMembers class Pitch: Object, Mappable {
    // MARK: Properties
    dynamic var id: Int = 0
    dynamic var pitchType: PitchType = PitchType()
    dynamic var name: String = ""
    dynamic var description1: String = ""
    dynamic var timeUse: String = ""
    dynamic var count: Double = 0.0
    dynamic var isUse: String = ""
    
    // MARK: Init
    required init?(map: Map) {}
    init(id: Int = 0, pitchType: PitchType = PitchType(), name: String = "", description1: String = "", timeUse: String = "", count: Double = 0.0, isUse: String = "") {
        self.id = id
        self.pitchType = pitchType
        self.name = name
        self.description1 = description1
        self.timeUse = timeUse
        self.count = count
        self.isUse = isUse
    }
    
    required init() {
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Function
    func mapping(map: Map) {
        id <- map["id"]
        pitchType <- map["pitchType"]
        name <- map["name"]
        description1 <- map["description"]
        timeUse <- map["image"]
        count <- map["count"]
        isUse <- map["is_use"]
    }
}
