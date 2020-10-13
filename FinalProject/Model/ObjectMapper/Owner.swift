import Foundation
import ObjectMapper
import RealmSwift

@objcMembers class Owner: Object, Mappable {
    // MARK: - Properties
    var id: String = ""
    dynamic var name: String = ""
    dynamic var phone: String = ""
    dynamic var address: String = ""
    var isBlock: String = ""
    var isDelete: String = ""
    dynamic var verify: String = ""
    var rememberToken: String = ""
    dynamic var district: String = ""
    dynamic var lat: Double = 0.0
    dynamic var lng: Double = 0.0
    
    // MARK: - Init
    required init?(map: Map) { }
    required init() { }
    
    // MARK: - Function
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        address <- map["address"]
        isBlock <- map["is_block"]
        isDelete <- map["is_delete"]
        verify <- map["verify"]
        rememberToken <- map["remember_token"]
        district <- map["district"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
}
