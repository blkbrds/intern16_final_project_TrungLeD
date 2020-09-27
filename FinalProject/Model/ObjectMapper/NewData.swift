struct NewData: Codable {
    
    let data: [Datum]
    let message: String
}

struct Datum: Codable {
    let id: Int
    let pitchType: PitchType
    let name: String
    let description: String
    let image: String?
    let count: Double?
    let isUse: String
    private enum CodingKeys: String, CodingKey {
        case id
        case pitchType
        case name
        case description
        case image
        case count
        case isUse = "is_use"
    }
}


struct PitchType: Codable {
    let id: Int
    let owner: Owner
    let name: String
}

struct Owner: Codable {
    let id: Int
    let name: String
    let phone: String
    let address: String
    let isBlock: String
    let isDelete: String
    let verify: String
    let rememberToken: String?
    let district: String
    let lat: Double
    let lng: Double
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case address
        case isBlock = "is_block"
        case isDelete = "is_delete"
        case verify
        case rememberToken = "remember_token"
        case district
        case lat
        case lng
    }
}
