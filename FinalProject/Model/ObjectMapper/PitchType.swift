import Foundation
import ObjectMapper

class PitchType : Mappable {
	var id : Int?
	var owner : Owner?
	var name : String?

    required init?(map: Map) {

	}
    init() {
        
    }
	 func mapping(map: Map) {

		id <- map["id"]
		owner <- map["owner"]
		name <- map["name"]
	}

}
