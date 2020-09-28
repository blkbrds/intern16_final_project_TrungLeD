import Foundation
import ObjectMapper

class Owner: Mappable {
    
    // MARK: Properties
	var id: Int?
	var name: String?
	var phone: String?
	var address: String?
	var isBlock: String?
	var isDelete: String?
	var verify: String?
	var rememberToken: String?
	var district: String?
	var lat: Double?
	var lng: Double?
    
    // MARK: Init
    required init?(map: Map) {

	}
    init() {}
    
    // MARK: Function
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