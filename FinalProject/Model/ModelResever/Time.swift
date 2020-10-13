import Foundation
import ObjectMapper

final class Time: Mappable {
	var id: Int = 0
	var startTime: String = ""
	var endTime: String = ""
    
    init?(map: Map) {
	}
    
    init(id: Int = 0, startTime: String = "", endTime: String = "") {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        startTime <- map["start_time"]
        endTime <- map["end_time"]
	}
}
