//
//  MockGamesListService.swift
//  PerqaraTestTests
//
//  Created by Stefan Jivalino on 25/02/23.
//

import Foundation
@testable import PerqaraTest

final class MockGamesListService: GamesListServiceProtocol {
    var url: String?
    var gamesListData: GamesListModel = GamesListModel()
    func getGamesListData(url: String, onSuccess: @escaping ((PerqaraTest.GamesListModel) -> Void), onFailure: @escaping ((Error) -> Void)) {
        onSuccess(gamesListData)
    }
    
    func getSearchGameList(search: String, onSuccess: @escaping ((PerqaraTest.GamesListModel) -> Void), onFailure: @escaping ((Error) -> Void)) {
        onSuccess(gamesListData)
    }
    
    
}
