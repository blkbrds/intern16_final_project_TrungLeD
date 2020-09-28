
import Foundation
import ObjectMapper

final class Data1 : Mappable {
    var id : Int?
    var pitchType : PitchType?
    var name : String?
    var description : String?
    var image : String?
    var count : Double?
    var isUse : String?
    
    init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        
        id <- map["id"]
        pitchType <- map["pitchType"]
        name <- map["name"]
        description <- map["description"]
        image <- map["image"]
        count <- map["count"]
        isUse <- map["is_use"]
    }
    
}
