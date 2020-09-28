import Foundation
import ObjectMapper

final class PitchType: Mappable {
    
    // MARK: Properties
    var id: Int?
    var owner: Owner?
    var name: String?
    
    // MARK: Init
    required init?(map: Map) {}
    
    init() {}
    
    // MARK: Function
    func mapping(map: Map) {
        id <- map["id"]
        owner <- map["owner"]
        name <- map["name"]
    }
}