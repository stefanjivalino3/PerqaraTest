//
//  MockGameDetailService.swift
//  PerqaraTestTests
//
//  Created by Stefan Jivalino on 25/02/23.
//

@testable import PerqaraTest

final class MockGameDetailService: GameDetailServiceProtocol {
    var gameData: GameDetailModel = GameDetailModel()
    
    func getGameDetail(id: String, onSuccess: @escaping ((PerqaraTest.GameDetailModel) -> Void), onFailure: @escaping ((Error) -> Void)) {
        
        onSuccess(gameData)
    }
    
    
}
