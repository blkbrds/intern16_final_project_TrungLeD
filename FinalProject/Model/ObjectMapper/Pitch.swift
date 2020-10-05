import Foundation
import ObjectMapper

final class Pitch: Mappable {
    // MARK: Properties
    var id: Int = 0
    var pitchType: PitchType = PitchType()
    var name: String = ""
    var description: String = ""
    var timeUse: String = ""
    var count: Double = 0.0
    var isUse: String = ""
    
    // MARK: Init
    init?(map: Map) {}
    init(id: Int = 0, pitchType: PitchType = PitchType(), name: String = "", description: String = "", timeUse: String = "", count: Double = 0.0, isUse: String = "") {
        self.id = id
        self.pitchType = pitchType
        self.name = name
        self.description = description
        self.timeUse = timeUse
        self.count = count
        self.isUse = isUse
    }
    
    // MARK: Function
    func mapping(map: Map) {
        id <- map["id"]
        pitchType <- map["pitchType"]
        name <- map["name"]
        description <- map["description"]
        timeUse <- map["image"]
        count <- map["count"]
        isUse <- map["is_use"]
    }
}
