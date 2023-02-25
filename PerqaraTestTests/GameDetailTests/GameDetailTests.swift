//
//  GameDetailTests.swift
//  PerqaraTestTests
//
//  Created by Stefan Jivalino on 25/02/23.
//

import XCTest
@testable import PerqaraTest

final class GameDetailTests: XCTestCase {
    var viewModel: GameDetailViewModel!
    var mockService: MockGameDetailService!
    
    override func setUp() {
        mockService = MockGameDetailService()
        viewModel = .init(withGameDetail: mockService)
    }
    
    func testGetGameDetail() {
        mockService.gameData = GameDetailModel(name: "GTA")
        viewModel.getGameDetail(id: "123")
        
        if viewModel.gameDetailData.name == "GTA" {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

}
