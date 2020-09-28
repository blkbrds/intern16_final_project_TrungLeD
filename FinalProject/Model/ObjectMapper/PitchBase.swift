import Foundation
import ObjectMapper

class PitchBase : Mappable {
	var data : [Data]?
	var message : String?

    required init?(map: Map) {

	}
    init(){}

    func mapping(map: Map) {

		data <- map["data"]
		message <- map["message"]
	}

}
