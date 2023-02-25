//  
//  GameDetailModel.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import Foundation

struct GameDetailModel: Codable {
    var name: String? = ""
    var released: String? = ""
    var rating: Double? = 0
    var playtime: Int? = 0
    var description: String? = ""
    var background_image: String? = ""
    var developers: [DevelopersModel]?
}

struct DevelopersModel: Codable {
    var name: String? = ""
}

