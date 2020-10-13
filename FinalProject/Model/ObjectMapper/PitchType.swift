import Foundation
import ObjectMapper

final class PitchType: Mappable {
    // MARK: Properties
    var id: String = ""
    dynamic var owner: Owner = Owner()
    var name: String = ""

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
