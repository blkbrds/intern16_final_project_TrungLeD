import Foundation
import ObjectMapper

final class Price: Mappable {
    var id: Int = 0
    var idType: Int = 0
    var idTime: Int = 0
    var price: Double = 0.0
    var date: String = ""
    var createdAt: String = ""
    var updateAt: String = ""
    var rateOfChange: String = ""
    
    init?(map: Map) {
        
    }
    init(id: Int = 0, idType: Int = 0, idTime: Int = 0, price: Double = 0.0, date: String = "") {
        self.id = id
        self.idType = idType
        self.idTime = idTime
        self.price = price
        self.date = date
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        idType <- map["id_type"]
        idTime <- map["id_time"]
        price <- map["price"]
        date <- map["date"]
        createdAt <- map["createdAt"]
        updateAt <- map["updateAt"]
        rateOfChange <- map["rate_of_change"]
    }
}
