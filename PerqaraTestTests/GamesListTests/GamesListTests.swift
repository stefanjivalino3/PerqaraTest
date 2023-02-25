//
//  GamesListTests.swift
//  PerqaraTestTests
//
//  Created by Stefan Jivalino on 25/02/23.
//

import XCTest
@testable import PerqaraTest

class GamesListTests: XCTestCase {
    var viewModel: GamesListViewModel!
    var mockGamesListService: MockGamesListService!
    
    override func setUp() {
        mockGamesListService = MockGamesListService()
        viewModel = .init(withGamesList: mockGamesListService)
    }
    
    func testGetGamesListNotNil() {
        var isNotNil = false
        mockGamesListService.gamesListData = GamesListModel(count: 100, next: "", previous: "", results: [GamesResult(name: "Test")])
        viewModel.getGamesList()
        
        if viewModel.gamesListData.results?.count ?? 0 > 0 {
            isNotNil = true
        }
        
        XCTAssert(isNotNil)
    }
    
    func testGamesListFailedToGetData() {
        var isNotNil = false
        viewModel.getGamesList()
        
        if viewModel.gamesListData.results?.count ?? 0 > 0 {
            isNotNil = true
        }
        
        XCTAssertFalse(isNotNil)
    }
    
    func testGetSearchGameNotNil() {
        var isNotNil = false
        let search = "GTA"
        
        mockGamesListService.gamesListData = GamesListModel(count: 100, next: "", previous: "", results: [GamesResult(name: search)])
        viewModel.getSearch(search: search)
        
        if viewModel.gamesListData.results?.count ?? 0 > 0  {
            isNotNil = true
        }
        
        XCTAssert(isNotNil)
    }
    
    func testSearchGameFailedToGetData() {
        var isNotNil = false
        viewModel.getSearch(search: "fdsafasfdsa")
        
        if viewModel.gamesListData.results?.count ?? 0 > 0 {
            isNotNil = true
        }
        
        XCTAssertFalse(isNotNil)
    }
    
    func testGetPagination() {
        viewModel.getNextPageGamesList(url: "https://api.rawg.io/api/games?key=688f6c56cc1a4fc38339d2b1f03c9107&page=2")
        
        XCTAssertFalse(viewModel.noPagination)
        
        
    }
    
    

}
