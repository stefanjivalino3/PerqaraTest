//
//  GamesFavoriteTests.swift
//  PerqaraTestTests
//
//  Created by Stefan Jivalino on 25/02/23.
//

@testable import PerqaraTest
import XCTest

class GamesFavoriteTests: XCTestCase {
    var viewModel: GamesFavoriteViewModel!
    
    override func setUp() {
        viewModel = .init()
    }
    
    func testGetAllFavoriteItem() {
        viewModel.getAllItems()
        
        XCTAssert(viewModel.fetchSuccess)
    }
}


