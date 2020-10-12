import Foundation
import ObjectMapper
import RealmSwift

@objcMembers class PitchType: Object, Mappable {
    // MARK: Properties
    var id: String = ""
    dynamic var owner: Owner?
    dynamic var name: String = ""
    
    // MARK: Init
    required init?(map: Map) {}
    
    required init() {}
    
    // MARK: Function
    func mapping(map: Map) {
        id <- map["id"]
        owner <- map["owner"]
        name <- map["name"]
    }
}
