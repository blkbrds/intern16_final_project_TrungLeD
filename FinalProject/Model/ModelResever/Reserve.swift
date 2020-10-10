import Foundation
import ObjectMapper

final class Reserve: Mappable {
	var id: Int = 0
	var type: String = ""
	var status: String = ""
	var date: String = ""
    var price: Price = Price()
	var pitch: Pitch = Pitch()
	var time: Time = Time()
    var weekAmount: Double = 0.0
	var dateEnd: String = ""
	var createdAt: String = ""
	var updateAt: String = ""

	init?(map: Map) {}
    init(id: Int = 0, type: String = "", status: String = "", date: String = "", price: Price = Price(), pitch: Pitch = Pitch(), time: Time = Time()) {
        self.id = id
        self.type = type
        self.status = status
        self.date = date
    }

    func mapping(map: Map) {
		id <- map["id"]
		type <- map["type"]
		status <- map["status"]
		date <- map["date"]
		price <- map["price"]
		pitch <- map["pitch"]
		time <- map["time"]
		weekAmount <- map["week_amount"]
		dateEnd <- map["date_end"]
		createdAt <- map["createdAt"]
		updateAt <- map["updateAt"]
	}

}
