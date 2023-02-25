//  
//  GamesListModel.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import Foundation

struct GamesListModel: Codable {
    var count: Int? = 0
    var next: String? = ""
    var previous: String? = ""
    var results: [GamesResult]?
}

struct GamesResult: Codable {
    var name: String? = ""
    var released: String? = ""
    var background_image : String? = ""
    var rating: Double? = 0
    var id: Int? = 0
}

enum SearchState {
    case lessThenThree
    case notFound
    case success
}

