//
//  Post.swift
//  FinalProject
//
//  Created by MBA0321 on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

struct Customer: Codable {
    let id: Int?
    let name: String?
    let phone: String?
    let teamName: String?
    let level: String?
    let star: String?
    let isBlock: String?
    let isDelete: String?
    let countReserve: String?
    let countCancel: String?
    let verify: String?
    let rememberToken: String?
    let description: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case phone = "phone"
        case teamName = "team_name"
        case level = "level"
        case star = "star"
        case isBlock = "is_block"
        case isDelete = "is_delete"
        case countReserve = "count_reserve"
        case countCancel = "count_cancel"
        case verify = "verify"
        case rememberToken = "remember_token"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        teamName = try values.decodeIfPresent(String.self, forKey: .teamName)
        level = try values.decodeIfPresent(String.self, forKey: .level)
        star = try values.decodeIfPresent(String.self, forKey: .star)
        isBlock = try values.decodeIfPresent(String.self, forKey: .isBlock)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        countReserve = try values.decodeIfPresent(String.self, forKey: .countReserve)
        countCancel = try values.decodeIfPresent(String.self, forKey: .countCancel)
        verify = try values.decodeIfPresent(String.self, forKey: .verify)
        rememberToken = try values.decodeIfPresent(String.self, forKey: .rememberToken)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
