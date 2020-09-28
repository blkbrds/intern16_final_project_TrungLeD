import Foundation
import ObjectMapper

final class Pitch: Mappable {
    
    // MARK: Properties
    var id: Int?
    var pitchType: PitchType?
    var name: String?
    var description: String?
    var timeUse: String?
    var count: Double?
    var isUse: String?
    
    // MARK: Init
    init?(map: Map) {}
    init() {}
    
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
